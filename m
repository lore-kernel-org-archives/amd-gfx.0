Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4B4BFF885D
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Apr 2026 09:37:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C68F10E331;
	Tue, 28 Apr 2026 09:37:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5AOwo7l1";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010068.outbound.protection.outlook.com
 [52.101.193.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C936010E331
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Apr 2026 09:37:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jmWjLQSyMxu9JQea2hsmN2Pat7diAlfQeTwPIvEFsiulD96cO0yExWVRTVO+2NYQ2kvqTDTrmFasCw+tkQGnwqsMeqOWOll9QY3hHdLqFm2D0jYkID+rG3WmuucIdxiG0A3lS8KbqlK/aAcZn8UtKCzscKfcnf3fa64UXgf0c2HTm+gBRFN1iTEtTF4+fVEiOuPDwPXjacxwI3ke1CXfBhBszagIVMdQNCz66FzxKQ+GRvm+5n6NlPdu2a3DhyWo7IevGiaEsAVdgWgipcy8v0BbQGe6UmyBqPAOzmYsODquWJk++QKauH6nbVhlt6xXl34dFmZ/k5MoGGlodmaujg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bYCBUQP19qf+L5oAFrReGtboZNQ2Olbs035Uq9+Y/Cg=;
 b=bZXhScS6pQuAggpVAKQzQ9aMvVXujOnekgYfd0UijmiuRxvcgZy0dasN7PUp2/vb9rRu30DVvsidHZcfFM/QMAFQ0s/vY0DJp8nEvbLjgs77cW+lUwF+0d22uTvfxCfLosTtcfM56F2RJq4sQNRLMzQxArm9NK3moMt/wwFDn/R+t0E2WpD2LTseJj3eAHe+Lf+r+ySTlJ7npGoB9CKFszER7NiA9QN2dTTZitWafNjcRZZCTHuzBupxrmoQ0mSDinvnmuH8ihf4uTAF3q1yEYYwY2LVDdJY4op/6mWa5DT3D1CfL1dNUUMfnLxFxZNo7gQ1+6QT2/HscKq1PtR9+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bYCBUQP19qf+L5oAFrReGtboZNQ2Olbs035Uq9+Y/Cg=;
 b=5AOwo7l1Oz9HGxZRKcg25pQEkttIyD8BC9++bMG+6FCpcO1NfXvuAKsk6t/M3V+z3D/3XRBhd19nJ2QAGzjxGHwmTK10SGUf/advMHgtjZO6So1asSw3BLtQPj3TGhnHVN0an9dtydKKMfkfMbCZrw7Zr0e//YdS4hEUnPgN+jk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5753.namprd12.prod.outlook.com (2603:10b6:208:390::15)
 by IA1PR12MB7733.namprd12.prod.outlook.com (2603:10b6:208:423::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.15; Tue, 28 Apr
 2026 09:37:33 +0000
Received: from BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::81e6:908a:a59b:87e2]) by BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::81e6:908a:a59b:87e2%6]) with mapi id 15.20.9870.013; Tue, 28 Apr 2026
 09:37:33 +0000
Message-ID: <d48d5800-9abb-43e3-b87a-b073abaad9ba@amd.com>
Date: Tue, 28 Apr 2026 15:07:27 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/8] drm/amdgpu: remove almost all calls to
 amdgpu_userq_detect_and_reset_queues
To: christian.koenig@amd.com, alexander.deucher@amd.com, Prike.Liang@amd.com, 
 jesse.zhang@amd.com
Cc: amd-gfx@lists.freedesktop.org
References: <20260427182723.1715-1-christian.koenig@amd.com>
 <20260427182723.1715-4-christian.koenig@amd.com>
Content-Language: en-US
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <20260427182723.1715-4-christian.koenig@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0118.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:27::33) To BL1PR12MB5753.namprd12.prod.outlook.com
 (2603:10b6:208:390::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5753:EE_|IA1PR12MB7733:EE_
X-MS-Office365-Filtering-Correlation-Id: 65fdfd4a-7cbb-41bb-010d-08dea509c618
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|18002099003|22082099003|56012099003; 
X-Microsoft-Antispam-Message-Info: VDQscASKU3O4O7gZ6mrtPU/5LA8Q6fVqDMDtwp0ByQVYaYUQW/K6IQk6Y1RaYnGM/DRSAYSuuhD/IbWS7qlBtZSHNeNSrp/nwyYc0V+bos4YwZSqpizKFG2OBQOkIHQ1upf+exksybA0vSGKnwyeuEGEfiSUMhYDY00njqiEdqXy02loXC+UNlqY7AvaXdcSFhZIitXBv7jx9Zalu2xZ27HzreJTIQEb2xevI65Ylka9JNZ5CZiU6vePRvWwbYc67runy1hee8cGn6YPLIGH2cLiUmfi9QY4swJZrW+JZU2cuGybLNe+ZYbMmDorYYA5GupKrppzlqwiO0/8QR1JRNieaHjlJlj+k8yTVhSga3RhjsE6P96ih17oqUKdB6qg71oxj9Ig7PCj5OzcdnT78HNtuDqApQkTNbu7rpA5YVlRNCDXtgoXfBnOR9L1H1zlecE0Tt8oVQph4OhO4odlugqSs7x4wh6w/JtqaFBZYZXUVjAKwAs5S0ee+I8gatboggTJDUwhyJOCdPkVP5fyP/nhMtGf7H8t4dvU8/GbNniiSG89HMbgxA4G9bqkWOF8E5aZgDcw+4q2qCGrkrx13luMcQpiC6mXZPY9vvOB8WKu1u+Hpn8QvI+YBg3Mx/0jvlEXMcNkwz1F6EU6vh+l30rOxVjJN8I7aAsPEZJVlCYKFR0PxT0Jhz8ruNBhWKqms/fbzqPjHwhiBu/2PjDqFqBxSGYCNTv2UmSUBt36c50=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TUgxZlFpZ2hudXNha0NPZlIwYUZMeTkvMU14emhyc2gvaXVZUitYaDNKaE1U?=
 =?utf-8?B?L1BkTDJUU0VHc2tSTE5wZTIzZ2l6a0toQUdXdVpLWGlqTTNGZE5ZZ0VwalBy?=
 =?utf-8?B?blFoeTdDc0lIZzc0MlBuaTNrWDN1eE43bmM4SVhOMVdEQjVBY1FNZi9YVXgz?=
 =?utf-8?B?UEVVUjVnbHRDajJMeDFoS3NBSlg1Z3JYYTg0WDd4VVhIdmh2LzU0VTlNelpF?=
 =?utf-8?B?WU5wRmlDTzAvd0Y2VlZuQllBcUU2ZDFHdmNJZHI5UWNYM1lXYS9XVElLT2k1?=
 =?utf-8?B?TERWMEh4MzdzODhUa1JPWHd2WUtvVHdaeDdtVnBtS3RmN3JCRXlTWUpvYXgw?=
 =?utf-8?B?UXZqYkt6alQ0U2ZVbHU1MGJVdy9Cd3g5T0pnbk53a2wwZ0FhYm02Tnl5ZFoz?=
 =?utf-8?B?RGttQWY2cGFmZnczRHAzS3gwOFdYOUJiOG9YNEpxaVFPcngzR0w5ZTd2MkdW?=
 =?utf-8?B?KzNBK3dXcytwZEVmb21BeER6V3NDQnREajNtcHRIQ3Q1UWxHeGFVVHJvVkpi?=
 =?utf-8?B?d2NUaXRWL2NQZVJma29YMzZWVkJNNStRRHV5VjlKdFZNZkNTUnpXa1NvQlAz?=
 =?utf-8?B?dlNJa2taUi9oRHRtTy9Kb1pPWUZkb283V1piS0dkZXpURlhBeTZRSllaZmV4?=
 =?utf-8?B?cDN2NjhyeTllOWw2NlBMZmUxMHp3TDJBeVE3UCszNjg2a1djQnNDOWhUaldq?=
 =?utf-8?B?L3ZHY2xuVDVHdm5qdGVEbGU4YjBqS0RqTFBKTThsZFo5aUFaV1duNitNcjZy?=
 =?utf-8?B?QVVhWWlsZGtYNVY5YTU4VDlnUkJvdkV5aFBRdHhrcndISWtmakRPbFpkZVNr?=
 =?utf-8?B?TWFjdzZaNmIxN1hlQ1ZqcFM5MDJZanB3UG5KL2pPcGJUSW8yUXdCQ0drMVRW?=
 =?utf-8?B?d3J2OHFDc1dKVTA4aTltMHNodWZFTDFtL0Z6cDJVR2o5YUxSbVpXa2dVUFE0?=
 =?utf-8?B?ZWFCL3hSNXNOSzdNbjVucmhHbXByb2VsOWhTQVVZUTB0ODF0Q1g5bWNjY3lQ?=
 =?utf-8?B?cGJQQVZpYUtvSHFUNHIzZlRqMW85eFNmWGNvNExKYmUwaTc3Z2Vld2FCMVJU?=
 =?utf-8?B?R2lsSkJRdXBTWWYvYXovVWgyRTZBWHJBeWRaaVNGeWpadEV6WFduN2VJT1ZY?=
 =?utf-8?B?V2NKOXA1VENESHlkR0RrUDAzZlQzTzlHOFFFVDhTZnZ4NkNBUm5hd3NXT3c0?=
 =?utf-8?B?dW1MS3kvckZETDRJVGZCTkdoMHNhWHMyUnArVTZwYTBSaWRUU1gxK0RzNHJ4?=
 =?utf-8?B?YkkydDE5NHdibDRjUHpZNjhkUDQxWTU5dlVGeExQcVR1SVhHWmk4Sk50bTZv?=
 =?utf-8?B?VjZQb0NFL3dXMjJsYTFjUjBmdEJEcmlKdFZOd2JvWTl6SDgrSUcwd1FqNFhH?=
 =?utf-8?B?NHcxeGp1M24zQ2pYaDRpRm5wNnNJWlg2NzVYMDZMb0pFWWVWUFhGYWJsN3Ew?=
 =?utf-8?B?OHA4KzJORXo2SlFIUmgyWlF5R2oyNmMrOE1ZZzE1eW1DMTZ2Y3dpN0NXQVR2?=
 =?utf-8?B?dlUvSlJHZWkyM1pka1VySmg4RjlvcFk2MDNtOEl2M09lR0NTS0pSRXZ0Y2hZ?=
 =?utf-8?B?MXRUQnk4STNEYWx1L0tIUU5oeWIxaXVjVzJtR1RsVzVkRE1JRXVnOFN1cEdn?=
 =?utf-8?B?V2ZQbERGNE1TdGl4RTRtM2FKT0xyVEpWYmo4bm4wT2lTVCtMa2doZ2JGd3Zt?=
 =?utf-8?B?bUVTUmJsQXVTNWEvOWw2eU5zcEVzSUljMnVNMzlLeUNDN21QOFdiSmxSNUJ4?=
 =?utf-8?B?SktEbWREMmRVSWNlK1hJMmp5MnVZNnFmaXQ2elpDMUIxSkpmQkdMZjRVWXZY?=
 =?utf-8?B?K3pHQ0ZmVUpxazA1NnB1Z1N0YU1OYVEySGRWd2JRUUxUYmxCVnIwSS9Xc1Rm?=
 =?utf-8?B?ZDhmQ0ZuYWZLMGJ3ZkxBaFhpTWhtYmlNL3M2RFRFb0JEU3FaVDhoOVdaZXR4?=
 =?utf-8?B?cms3bUdiaEF0WHRwdGIvTWwrN0RtclFuOUV5NGdHb1V1MFU2cU5NeXR2bFFG?=
 =?utf-8?B?Sjd6ZWNjUktYUkVSclFaUVBPQjkvQlBTYlpVMCtEWVJ2cFR6SFhmeThVTHBn?=
 =?utf-8?B?d080K0RsS3h1YkljN3B3Vlh1U0ZiTUl6dS9yR3BKQ0lUb3kxdVJENE1rQ2hw?=
 =?utf-8?B?eHduU3ZwL29TcTBXNnoyY3BSeTk4eitpZEIwNDRYaS9ld1dhaFIzTlExSTFv?=
 =?utf-8?B?WXB4Um5hUWNoNEhkU3dHczl3Q1NBK1BDU28yRTJLaUVlWUVrU0pnVzZBVTlJ?=
 =?utf-8?B?VUp4MlVzaEw0c2xPWW1iT2dUZlY4a2srOUVheFEvMUxhcW5zZVVyNkVCbERC?=
 =?utf-8?B?OTk3eGJiODIyMzVockgrOUROWWF5S1V0cEtsaktUZTdITlVJbm1VQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65fdfd4a-7cbb-41bb-010d-08dea509c618
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 09:37:33.3435 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +O7TicEQ7G7+BVZ7eNRxGtZVhQ01y5tEf/tM07hiArn2wKeWwIdv6ZgM/Khz696kjm5PJri1nduo6t2tYNHVUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7733
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

Reviewed-by: Sunil Khatri <sunil.khatri@amd.com>

On 27-04-2026 11:57 pm, Christian König wrote:
> Well the reset handling seems broken on multiple levels.
>
> As first step of fixing this remove most calls to the hang detection.
> That function should only be called after we run into a timeout! And *NOT*
> as random check spread over the code in multiple places.
>
> Signed-off-by: Christian König <christian.koenig@amd.com>
> Reviewed-by: Sunil Khatri <sunil.khatri@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 38 +++++++++--------------
>   1 file changed, 14 insertions(+), 24 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> index 62d155d6e4ed..fb3c0425cf22 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -345,23 +345,18 @@ static int amdgpu_userq_preempt_helper(struct amdgpu_usermode_queue *queue)
>   	struct amdgpu_device *adev = uq_mgr->adev;
>   	const struct amdgpu_userq_funcs *userq_funcs =
>   		adev->userq_funcs[queue->queue_type];
> -	bool found_hung_queue = false;
> -	int r = 0;
> +	int r;
>   
>   	if (queue->state == AMDGPU_USERQ_STATE_MAPPED) {
>   		r = userq_funcs->preempt(queue);
>   		if (r) {
>   			queue->state = AMDGPU_USERQ_STATE_HUNG;
> -			found_hung_queue = true;
> +			return r;
>   		} else {
>   			queue->state = AMDGPU_USERQ_STATE_PREEMPTED;
>   		}
>   	}
> -
> -	if (found_hung_queue)
> -		amdgpu_userq_detect_and_reset_queues(uq_mgr);
> -
> -	return r;
> +	return 0;
>   }
>   
>   static int amdgpu_userq_restore_helper(struct amdgpu_usermode_queue *queue)
> @@ -390,24 +385,21 @@ static int amdgpu_userq_unmap_helper(struct amdgpu_usermode_queue *queue)
>   	struct amdgpu_device *adev = uq_mgr->adev;
>   	const struct amdgpu_userq_funcs *userq_funcs =
>   		adev->userq_funcs[queue->queue_type];
> -	bool found_hung_queue = false;
> -	int r = 0;
> +	int r;
>   
>   	if ((queue->state == AMDGPU_USERQ_STATE_MAPPED) ||
> -		(queue->state == AMDGPU_USERQ_STATE_PREEMPTED)) {
> +	    (queue->state == AMDGPU_USERQ_STATE_PREEMPTED)) {
> +
>   		r = userq_funcs->unmap(queue);
>   		if (r) {
>   			queue->state = AMDGPU_USERQ_STATE_HUNG;
> -			found_hung_queue = true;
> +			return r;
>   		} else {
>   			queue->state = AMDGPU_USERQ_STATE_UNMAPPED;
>   		}
>   	}
>   
> -	if (found_hung_queue)
> -		amdgpu_userq_detect_and_reset_queues(uq_mgr);
> -
> -	return r;
> +	return 0;
>   }
>   
>   static int amdgpu_userq_map_helper(struct amdgpu_usermode_queue *queue)
> @@ -416,19 +408,19 @@ static int amdgpu_userq_map_helper(struct amdgpu_usermode_queue *queue)
>   	struct amdgpu_device *adev = uq_mgr->adev;
>   	const struct amdgpu_userq_funcs *userq_funcs =
>   		adev->userq_funcs[queue->queue_type];
> -	int r = 0;
> +	int r;
>   
>   	if (queue->state == AMDGPU_USERQ_STATE_UNMAPPED) {
>   		r = userq_funcs->map(queue);
>   		if (r) {
>   			queue->state = AMDGPU_USERQ_STATE_HUNG;
> -			amdgpu_userq_detect_and_reset_queues(uq_mgr);
> +			return r;
>   		} else {
>   			queue->state = AMDGPU_USERQ_STATE_MAPPED;
>   		}
>   	}
>   
> -	return r;
> +	return 0;
>   }
>   
>   static void amdgpu_userq_wait_for_last_fence(struct amdgpu_usermode_queue *queue)
> @@ -654,7 +646,6 @@ amdgpu_userq_destroy(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermode_que
>   #if defined(CONFIG_DEBUG_FS)
>   	debugfs_remove_recursive(queue->debugfs_queue);
>   #endif
> -	amdgpu_userq_detect_and_reset_queues(uq_mgr);
>   	r = amdgpu_userq_unmap_helper(queue);
>   	/*TODO: It requires a reset for userq hw unmap error*/
>   	if (r) {
> @@ -1270,7 +1261,6 @@ amdgpu_userq_evict_all(struct amdgpu_userq_mgr *uq_mgr)
>   	unsigned long queue_id;
>   	int ret = 0, r;
>   
> -	amdgpu_userq_detect_and_reset_queues(uq_mgr);
>   	/* Try to unmap all the queues in this process ctx */
>   	xa_for_each(&uq_mgr->userq_xa, queue_id, queue) {
>   		r = amdgpu_userq_preempt_helper(queue);
> @@ -1278,9 +1268,11 @@ amdgpu_userq_evict_all(struct amdgpu_userq_mgr *uq_mgr)
>   			ret = r;
>   	}
>   
> -	if (ret)
> +	if (ret) {
>   		drm_file_err(uq_mgr->file,
>   			     "Couldn't unmap all the queues, eviction failed ret=%d\n", ret);
> +		amdgpu_userq_detect_and_reset_queues(uq_mgr);
> +	}
>   	return ret;
>   }
>   
> @@ -1380,7 +1372,6 @@ int amdgpu_userq_suspend(struct amdgpu_device *adev)
>   		uqm = queue->userq_mgr;
>   		cancel_delayed_work_sync(&uqm->resume_work);
>   		guard(mutex)(&uqm->userq_mutex);
> -		amdgpu_userq_detect_and_reset_queues(uqm);
>   		if (adev->in_s0ix)
>   			r = amdgpu_userq_preempt_helper(queue);
>   		else
> @@ -1439,7 +1430,6 @@ int amdgpu_userq_stop_sched_for_enforce_isolation(struct amdgpu_device *adev,
>   		if (((queue->queue_type == AMDGPU_HW_IP_GFX) ||
>   		     (queue->queue_type == AMDGPU_HW_IP_COMPUTE)) &&
>   		    (queue->xcp_id == idx)) {
> -			amdgpu_userq_detect_and_reset_queues(uqm);
>   			r = amdgpu_userq_preempt_helper(queue);
>   			if (r)
>   				ret = r;
