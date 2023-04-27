Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4437C77B61
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Apr 2023 10:02:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C7FD110EB14;
	Thu, 27 Apr 2023 10:02:27 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2084.outbound.protection.outlook.com [40.107.92.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4BB8710EB14
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Apr 2023 10:02:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hKujkRp7SIi9KidaWP45penjZngNwzyDBEEy5Abk5UBhd39jg/Ef+Wyq3EdXO8mRUOkuCMpDymllxgqxbWSXQZ9l1LSVr+2xv9KQ/wjCbfjzzQBe+CJcGj9pYTw00QsBrTQiqxk4tilJtV25b6Gl/RWkODg3s2jcVW7XMVRtfS1vKJxzVUpdCRtkp+dQ3ZK/SFx0XWPfGo1Ygq4rtD3OyZKYEpEWVyMCDZ2jKyIEG/U8ILH2QLBlAvkJIXU7SFrKechZHiYM8bAPB1CArIluqWMsb/1/sBN3WHcg/laaoJOtSC7yrmVqrcQnR4VQ/4LAsx3FjHHuGEWaffTxwnV1tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kuAdph7KcLTOV6RcrN51nKzyNldWmzerBpQTnLyUO/M=;
 b=RjZzIzrIW5vARqRXnRJVXwN2dujcrH9fBJKLgdYYCvDyo+Upf2YAoBFCQk0mHjgZjwWCuqxUB7VgudqNyJ362+7eRLy1sBtZIHDJRkIdt/YbLUcLB6augXkQtddgd5u8/Ql6hi9+mIlAqW2cMHyY9knE3zsHZhH56Gxv6jkLO0vhtjgIVIC/98SXrhYKjtI8fCWKAe/znRi64i4QDbdizzAMvpngrxo5+9ko+UbJhl3zQP/OmMmx3ifuXvXUbnWzyg9jd50/LPetaAt8TkZVOq6fp3ul6AmEOdwtvj2mhcNUfv+r1I3r5Cr+ALRUKohBT5YzDfYbJkOIj/oDy81TGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kuAdph7KcLTOV6RcrN51nKzyNldWmzerBpQTnLyUO/M=;
 b=HQB/CNqFzqoJGuWOKh+ab601k5k42vL3/X7k81xWT21t6kYKf93IfUhSShIP7r3BUTVZ9p/7v2qbV/VLAaPfWp/Tij4HRVVP9N6zvY67SdeA2URVWwEEltvcrJtfUqKBYKbKULF5GT2UeVp0VpumJsII2NPwt3UauVyG8xtERZk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by IA1PR12MB6411.namprd12.prod.outlook.com (2603:10b6:208:388::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.21; Thu, 27 Apr
 2023 10:02:23 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::d2f8:7388:39c1:bbed]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::d2f8:7388:39c1:bbed%3]) with mapi id 15.20.6340.022; Thu, 27 Apr 2023
 10:02:23 +0000
Message-ID: <87f05fed-2aab-9809-2730-f6396cd8c8bd@amd.com>
Date: Thu, 27 Apr 2023 12:02:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] drm/amdgpu: drop redudant sched job cleanup when cs is
 aborted
Content-Language: en-US
To: Guchun Chen <guchun.chen@amd.com>, amd-gfx@lists.freedesktop.org,
 xinhui.pan@amd.com, alexander.deucher@amd.com, hawking.zhang@amd.com
References: <20230427014030.754869-1-guchun.chen@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20230427014030.754869-1-guchun.chen@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0214.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ac::8) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|IA1PR12MB6411:EE_
X-MS-Office365-Filtering-Correlation-Id: 95e06c7d-797d-48b8-7659-08db47067eb1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zXbx/0cbuxbyZGpjWtrLMLJgUOwZd6cgmF83Bx18IFeXDLUefL69kshtO1FthVCaB0hll1m5n2puGvvGsquQP2mDMyrBKtwjhI5w+jWDmN/+JfOUJnB8DOVnuxboW7I8WP2r8rxKIseUpCdBa7lnkczraF+HU73bvKs0k1GtkACuc8CWFWz+yWpapv2ADg7coqDilf7DvFpOpN2NXxnGwqgmiD+L3p/HBzqLpRuhVawwVOUo6tgWYA8WOdTrEMUW85Rhokt/mWkLkVcA8ii5mkHChfX/7Rm65CQj1vvv/lI0C/3sa1/0y8DMltAUXJCvteCk5OjV9e+vX9ZnjN7fbaAkZTSMPeIg9AQwX4emGbmB1D9kllXGgjs1GDPV1z+XOgEmQe4Xz8UpT6RvFqAe6T9kMR5sd0NRKJDBncbvfKMFmRjd/j7roUA49rrAVDPWDyxuc5Zc0nJDLORwvHvAukII+zwp98oZr97v+AeHeK23BruCG1zrfN+oVa4kF+iUhmbnSc0Ev8+CQPJezHkgKoRUWnv4HL35M/P8uBW9lEz5jY60RVzyFDOT81wYeGgEXzThw/itmakOGyNchAhKCTm3cJTwOV+nYO7aF4KowUg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(396003)(366004)(39860400002)(376002)(346002)(451199021)(316002)(6636002)(66946007)(66556008)(66476007)(6666004)(966005)(6486002)(86362001)(36756003)(31696002)(478600001)(186003)(6506007)(6512007)(26005)(5660300002)(2616005)(41300700001)(38100700002)(2906002)(66574015)(31686004)(83380400001)(8676002)(8936002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d29aRWdzc0E5a2loYlpvU0diUE5sbTNFc0Zmcyt6TkRXdGFlUDNqb05mZUZt?=
 =?utf-8?B?TTNaNmNIdHFjVVBOUVRZRzJaOWtnVzN5b0prNVJTcVh6SlJMcXREeGFXYWNV?=
 =?utf-8?B?aytYSGorYnViUkQ4eDA2YTduU0x2OEhSUzdwNVdYU2YzbitBTHNiOWU2ckd4?=
 =?utf-8?B?S0pMWlB0ZTQybWpNYkNhRXN0L0ZqLzcvQXBMQ2YvcVNuY0JmSUphbW54V082?=
 =?utf-8?B?SzZFOUVBK2xVbHZQY3ZtVWljMlVrUTVkNFRBRnZJdmtUU1hsWEVLUVZybEs3?=
 =?utf-8?B?Q1llMm81cktiTXZvYXJCdExneWl4Y3ZWNmx1Y1FGaUFIMiswZk8wQThidWpH?=
 =?utf-8?B?K1kwZE12Q1drNmI5RTVBK01HZVVVeDl2ZndKV1lVelZEUHczK3pNeXF6b2tC?=
 =?utf-8?B?L0pBajFYTVd6QUF3eXdtU2NwTEF0RDlQdGxIanZnN0MvQ1MxSHd5bGVweFNN?=
 =?utf-8?B?NUFqN1dnTG55ZlJTUmgvZzZoUWtSUDZjUkd3a2lJU0s5aDVtMTFYU0VzVzNR?=
 =?utf-8?B?MU9hZzkrbW0zU0NLei9YYnpXUDJiTU41M0lvc1ZXOXZCT1JsSnhlZ2FBVWwx?=
 =?utf-8?B?ekplS0s2RkhnNXZQamFDeEEzcEY2VmJVK2dOZzNVUm1BRWlVeDJzMXVNVTVy?=
 =?utf-8?B?WnF3QVFhY1p2dmtjRTNPOHYzWE9kL0VGei9uNUJ4c1lBZEJva2w2VlAyclhz?=
 =?utf-8?B?Y2w4dzNLZE5YaHF4R2hFY2cwQ2xVUWdBNjdITmlnZjMwTktXQXA3bk9EZTBY?=
 =?utf-8?B?VHBGeWUzYU1PVDZObEhWR2tQMDRVV0lHdkdaSmxzTU5sSXdUZTI0UVN2L3Z2?=
 =?utf-8?B?STBidnRGNjRWSVc1S09yZWg5ekpwTStqek54QmUyMXpDb3JPT1duTzVmQlNX?=
 =?utf-8?B?Umd0MjNWeGMwM0tCS1VOOVZJOFNmQlJPbzFLQ3lITnNpRlFjSXNDeC8wRWFJ?=
 =?utf-8?B?ZjJQbzlnWWVuQlJpeUN3K05WSXdibkRMbGFHUWVaZVRlYUtaRGNRaUlpaXl6?=
 =?utf-8?B?TWlCL0R4N2RZSW8vN2xGelpQTVI4dFdKUkVBYmJPTmtVU2NOZnlxb3RGYkFO?=
 =?utf-8?B?R3d0NDF6TkN1YTdGVFcrTUEvVCtaT2c5R0l3SUZ2VDV5ZkVwLzFnVnM5R3Bn?=
 =?utf-8?B?MzlaLzdrMWpjY2FKWTZ4WUFmVENOTXpOSjRwNDB6cUZiazNFUHd1N2c5UHlF?=
 =?utf-8?B?UzY5ZDdIR1RoT29mNEJ1cjBxeElLMllWTm45T3FoQU9nc0ZlUGlsVFQrdVQ1?=
 =?utf-8?B?YjJLdjNqMHpNNEdWcStDOTBkbjdiN01QQXByalJCVlJ5M2c3RU5oY2JpRlBs?=
 =?utf-8?B?OXJrUnZVaVcxdCtYQzBYSXhlS29TYzV2M2dWdlRweXUzY1dUMUg4RjNvd3hz?=
 =?utf-8?B?d0x4cFErYmVwK09NbXkzemRZZmpLTUdId2diS2lkNzNLQnZVN2ZhRzBuTVVw?=
 =?utf-8?B?MXRnbHJNRkF0NUpQWTJOekR2NmtHN282cEkxbVd5S0k1dzA1SjVUZ2hrQllJ?=
 =?utf-8?B?T2JKbGJhaEU4U2taa0haYjFyWmd1Tms4bG16RHYwUXNDWC9ia0I4dVUvM0Js?=
 =?utf-8?B?cklUMWlCYmI2TnZwRUxQMGhwK0NuVytHRWpoZFBSZGMxTVpTUkRIbmk0LzJ0?=
 =?utf-8?B?ZHlJVWc5eFV4VFFDUW1TZlJGYXpXUklOR1FBcHdyY1N4Y0hkQ1BKZDlwOXFu?=
 =?utf-8?B?L3VWNWhoSVk4Y0Q2V0N2RVJvc3NlUEdtVzkyVmM4UFEzUC9FMklQdi9zbmVJ?=
 =?utf-8?B?V2hBL1VXbVU0ejlHRDJiMGRWcGphUFpOVzFMZ0RFQnB2WWZOMVlCVUczZHV4?=
 =?utf-8?B?NVBqQUkxU2c3MVlWeTdEazlQeXhvVDBaUVJOTkwyOFRHQ0ZVRGNQbDJVTXFX?=
 =?utf-8?B?M0NWNWJ2MXFzWTFueEdzREQrbWFZSnFXMFIyUmNGTXpXdG5hZDZ4dGVEYWpE?=
 =?utf-8?B?QVduU1hvKzJBakp4eEx3ek5yOWl4ZzJmLzJ2MDA3TU9VUXdTZE9GZFVvdSt4?=
 =?utf-8?B?WHJIa0dkYzJBUTNhUFROaW52K2ZUanQrWDU1SWtVWnJvcVVpVVFha0lRZmRh?=
 =?utf-8?B?d3lXVG5VOGRBWlBybE1LSmhQRE1DbWRUNklZeHorblVwckxXN1J1VXRXY09K?=
 =?utf-8?Q?QnFM=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95e06c7d-797d-48b8-7659-08db47067eb1
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2023 10:02:22.6603 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pWRP6mKXLBrMtsAK+Qx/9VG/obyE1WuUzqcLXXuK5nizgdMs6RaZpSDSRuqSQzpp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6411
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

Am 27.04.23 um 03:40 schrieb Guchun Chen:
> Once command submission failed due to userptr invalidation in
> amdgpu_cs_submit, legacy code will perform cleanup of scheduler
> job. However, it's not needed at all, as f7d66fb2ea43 has integrated
> job cleanup stuff into amdgpu_job_free. Otherwise, because of double
> free, a NULL pointer dereference will occur in such scenario.
>
> Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/2457
> Fixes: f7d66fb2ea43("drm/amdgpu: cleanup scheduler job initialization v2")
> Signed-off-by: Guchun Chen <guchun.chen@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 13 +++----------
>   1 file changed, 3 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> index 08eced097bd8..2eb2c66843a8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> @@ -1276,7 +1276,7 @@ static int amdgpu_cs_submit(struct amdgpu_cs_parser *p,
>   		r = drm_sched_job_add_dependency(&leader->base, fence);
>   		if (r) {
>   			dma_fence_put(fence);
> -			goto error_cleanup;
> +			return r;
>   		}
>   	}
>   
> @@ -1303,7 +1303,8 @@ static int amdgpu_cs_submit(struct amdgpu_cs_parser *p,
>   	}
>   	if (r) {
>   		r = -EAGAIN;
> -		goto error_unlock;
> +		mutex_unlock(&p->adev->notifier_lock);
> +		return r;
>   	}
>   
>   	p->fence = dma_fence_get(&leader->base.s_fence->finished);
> @@ -1350,14 +1351,6 @@ static int amdgpu_cs_submit(struct amdgpu_cs_parser *p,
>   	mutex_unlock(&p->adev->notifier_lock);
>   	mutex_unlock(&p->bo_list->bo_list_mutex);
>   	return 0;
> -
> -error_unlock:
> -	mutex_unlock(&p->adev->notifier_lock);
> -
> -error_cleanup:
> -	for (i = 0; i < p->gang_size; ++i)
> -		drm_sched_job_cleanup(&p->jobs[i]->base);
> -	return r;
>   }
>   
>   /* Cleanup the parser structure */

