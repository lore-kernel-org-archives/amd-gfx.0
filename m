Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 114EFF9B607
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Apr 2026 10:20:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 937EB10E042;
	Wed, 22 Apr 2026 10:20:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FVftBodU";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013032.outbound.protection.outlook.com
 [40.93.201.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ECF1D10E9A7
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Apr 2026 10:20:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gqenvh0R2B95kSUKRkDJE1sxbmS+BlXdLcEXKGhQkc1vD9Eq1EfbQeq4e9/eoQtQ7qI7B5oZXK06jIt40E4lhDlnuwE+2Rw7+zcbw5eMym/KtCYOFMja93T96oZ4RZbOKcCA51XGc0CFcidJoowx35QvL3z7dQWv6ubv+mceNTARHb3KMZ9QrB6BMb27pFVfNJM8/Fyf3NGZBPryHsGpMNDIbmCAJH+QOh7zW2VzeKf8HFsnNSpsQ4V6NcI5D090QZGp6PvI9XthGozHF6vl1RdOUIwCf1Byo/buQGutifWB+DywWkkeBT7YdxPvHhH+SM4jYdBV/0zhw3yrv8+RBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CABjCl7JuJ4elKkP3XjCKvHic0ng+YGfP6ZlFhyDQ4w=;
 b=iYUbFwq4pJ2udPljaFIzjB85XwxfycJNsFukfvvo4bSwoyl5hyZp2mwGFq3weRv28crgBqXw2O/xPiTH0bkbJBWsI1VIfu+UaTlJSUbHqaOiNQI2AoDobNAgkqinvoU5TVyMuO1I1apTFU+LKE0kwAIqaWrS/b9snPba9d0NjTpTVOHdte1rY2xEOQuLaxJVhMfBg+OOz/DmuTXFhE+cneQq6a3GO4VtJvhpi2wyn9kmGl2YARp5VZvsKnutMu0l98uY1grDz5NJ9f0jekOe1/pG1PU0GUroJ5p5ln7mypYgYNcqBD7cFhieZWCuU9kbLJQXup6QrLmw94A7j0a0XA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CABjCl7JuJ4elKkP3XjCKvHic0ng+YGfP6ZlFhyDQ4w=;
 b=FVftBodUcs2wX/27pv+DEQbzfkOiEC/xJBqkJ/yL4sChIOSxFvqFEQLoENgXKFAXbS8JMi7m7EMWgdcL32kipUMxFVzImYn1hwn/Q1czjK8RYgK/RYMwpcosi5+4cjqP4wkngkJ6hApTmsOheeBP9/J6v34POPHbJkei00zDYpE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5753.namprd12.prod.outlook.com (2603:10b6:208:390::15)
 by BL4PR12MB9536.namprd12.prod.outlook.com (2603:10b6:208:590::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Wed, 22 Apr
 2026 10:20:10 +0000
Received: from BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::81e6:908a:a59b:87e2]) by BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::81e6:908a:a59b:87e2%6]) with mapi id 15.20.9846.014; Wed, 22 Apr 2026
 10:20:10 +0000
Message-ID: <30fcb9fe-cef3-4320-b430-735071e808c8@amd.com>
Date: Wed, 22 Apr 2026 15:50:03 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/11] drm/amdgpu: remove almost all calls to
 amdgpu_userq_detect_and_reset_queues
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 alexander.deucher@amd.com, Prike.Liang@amd.com, amd-gfx@lists.freedesktop.org
Cc: christian.koenig@amd.com
References: <20260421125513.4545-1-christian.koenig@amd.com>
 <20260421125513.4545-6-christian.koenig@amd.com>
Content-Language: en-US
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <20260421125513.4545-6-christian.koenig@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN4PR01CA0096.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:2af::8) To BL1PR12MB5753.namprd12.prod.outlook.com
 (2603:10b6:208:390::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5753:EE_|BL4PR12MB9536:EE_
X-MS-Office365-Filtering-Correlation-Id: df309b60-349c-4289-58f2-08dea058bb7a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|18002099003|56012099003|22082099003; 
X-Microsoft-Antispam-Message-Info: AOHGIjGTLoZ/5Tb+m+KBGq5I2NIvz/6AtGutsD3k6mGRlhlCpTDGBC1s+x5X+YiRezWdNIWtZK6rnd3H51qPiQ0niC3n5NIVidn9IjjbXnowwkSruGcOXCigJCGKtFXbWBy4/M+Z3Glq2Dn9gVMYamg9FK4ivvQze4ak4SEUFVZjSXJ9aFlhsOO6/iwi+g4jc7Hc4tPnJDlG9YOdpYEUpKnRHp7Hbztb1LWzZxm0+iAM3tp68tXLp75Tf/BHM8p7GJUz7bmH10jUbsRenX+jiEsfju1VnCBrNz+zN7FPc6QM6KC+PjWEjBtCPY4M+2JLaimxM33PFTQiiB3AmvE8owmSrYTKcqDYtZWRod2ykVY1MFRR/8V0PDK39rH/RKTzJ4+6pmt8I/sWEIPtex8nmY/o9knvD9N157O1N7YxqC0snvOxUvSenYHW74/YtE3wINjuvqF9QUdi+/VS+mOMTt0WU1R2RylluSD2corU/acJ/lpOOfYrqv7RZiISBcPkIhZ1YWPQkGE/5AhO1iQ5iMN9ha/BvdVrqpuIK9lcChu9UKW1/jMKZlQl7VkoFlmh+aXImUGiZWdaEtpiIxvxMKReqap+YX+j3+Xz5tcj/xo6F6co7yZWkjBHcNVPNhLirDvMP8ZxpUrilPrTpNWMJJsa6gizpPOgSl+DshjVqtSYkiF327Ldi8SzXhJ3zK0J2os7f19w+6NT1jEOvYyfnqvFYMXvoR39NiCm9U69f2k=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VnFJd3YrQm55YWxVSWhYRFJBV285aGQvMGZVSUxYcUxQTVgrWEFZd3FCWUo4?=
 =?utf-8?B?aG40NmVBLzlEUUhmVEUvMTVHbGJkaGQ4bTJpTENJRGlSUmx5VjJsMWUrRmpE?=
 =?utf-8?B?emJkakN5MDZ5ZExmdXBuMFY3dk9XTGZORnVWQUxSTEgxNGo2ZzI1NG42aVhT?=
 =?utf-8?B?Z1FLcUNNekE2MnRKNFNLNFVFRm5KaXZHKzhqem12bGg2OCt3Y1N3T29JMzBZ?=
 =?utf-8?B?NGx2MzdsN0dzU2c1SVBaMzI3bXFOTzJ1MjRneTIyTmRwL0xwb2JJTTVFdGow?=
 =?utf-8?B?TEVpSWlXSmJocllTbVdWUkZKSGQvRjZRcHpEUzA2M24yYkpKR2RlaWlpUHkv?=
 =?utf-8?B?djdMeE8wbVZnOTNXM1piMk9ZMi9Qb3h0VUxoY2tCeHkvWGYyZ1pJSDBHMndE?=
 =?utf-8?B?R1BKOW5oMFVtdHE3YlJJdm1sS04vNWx6WDB5dEh1QjFBVjl6UFFMT0g4aDNU?=
 =?utf-8?B?VzBwQjRNVjIyTUlkdGFmODFzbHpNT1hRaHhxNTR0NlZjaVhyQytlZDA2ZkJp?=
 =?utf-8?B?VG0vKzhtUEJObG5aNjdScTFiOGh5MFlDQzBGV1RJN1JMNjlFZlRnS3k3RUE5?=
 =?utf-8?B?dGIzUWU3RzY1cHFCN1hKOFVsWk1zZ3lXYlRsWHZBbzJlTmxWNlRZdEtJakFQ?=
 =?utf-8?B?YklNYjQvdTRTMDRCY2JGMCtjQnVyTkxZVTVZMjhBRFFxTnpnZ3daQ1QrY1Zl?=
 =?utf-8?B?WlU1cndMMG55YmZBU1lyVUt2S1hVQUJ6ejRjWS9BQ0ZyQk15citrellVaEd3?=
 =?utf-8?B?YjFITUEyN3BxL2xTNVQvLzdKczVNankwZ1hweDE0Z0tsSnBsSXhvVVhVRS9q?=
 =?utf-8?B?UGQvMGo2c2ZQSnYrNzZVYkZSa0I5bzBjcFpGY0txdWYrNUMyWjkwQXJMTkRh?=
 =?utf-8?B?eFhSd2dNU1BnZGxVRWxkQ04xQ2tUVHZzSEFMVXJvLzRqOVFYUndzR1AzdENk?=
 =?utf-8?B?dVd0Rk5Ja01TMElXZWY3anRkayszcTR6dktRY2U4M1B5ZXU0clp3RlYwKzlD?=
 =?utf-8?B?dTRUM3psZjU4ZnN2NXR6N2JTbDJsenNDcG5zenppNmFhd0lyYXQvc0dhc01L?=
 =?utf-8?B?eVkydmxTZHBRUUNKWlh3N1NwY1kxbk5FNnJxaEdKMXh0b2x6YW1vZG1xRkFp?=
 =?utf-8?B?MHQ0M0I4eWhXZ1p0WXRkK2Y0V3psYU9IbzNsc0RIbUpFNWxnUURrcjZhUHVX?=
 =?utf-8?B?S210d2NDL3RFV2I1YmVMSjMxOFJVd3N0K3dyNmJUUkNiVWRpYXBTcXh6aGVE?=
 =?utf-8?B?bklROFFIcWM3dlBpUkk5SGxvbEtWemNjQmt2ZkVKRlBRenAvZWdMYW5uOXZi?=
 =?utf-8?B?RmQyQ0FhR25yYjdNOUk0MWNrNE5lUGJKblJtSUR0ZmVDQkwzOC9ac1A4WjRv?=
 =?utf-8?B?cnBEN2xOUUVPZDdETmRiUlo0VDZYdmtZeTBQd3MzWldQUkR0SmRDTnpyL2dH?=
 =?utf-8?B?bG5OMmVESlJYYXVzU2YrT2d3YjBuWGlvY3dueGRwNG15dStzUW1nOVVYU1Vw?=
 =?utf-8?B?TVlPcnJna0ZBNWJqbEs5eVA2WlNtckMrZXNBY1FrSjlHVDBUdTBHN0VQem02?=
 =?utf-8?B?WHZhdm5ISC94V3ZZSHdPZlFZNXJucTdCSXBkYW9SeGVjMmV3ajgrblUvdDVa?=
 =?utf-8?B?N2JvUEVac0xOZTZPOVJLUmJHZTM1V0Mvc3VGTHA0V2pQRS9RYlM0M0FFNHZG?=
 =?utf-8?B?WVJaZlZBZzB4aytnbG9hMHpLYkFDT2l2YTZQQkNFa21rMkdGU09lQkp5Nkxs?=
 =?utf-8?B?UDZvUkhUR0c4aXAzcDZOZU43R2FuQjZiWUltMEFvYWVDTUt0WDhpWTdtMkNX?=
 =?utf-8?B?bGdtVTBrSlRDYlVvNjgyOFV0VzFiT2pUUmhaU1JqNHlRakJaOCtZSHlXK2Nh?=
 =?utf-8?B?RVZpVmcyRFBvc0YzZkZBMExwNTJUMlovc1FHWFV2MHF6SExWeUxtdVZLSW9L?=
 =?utf-8?B?eG5XdmxoeE5RczRJT052dUh5UysyMmRoZlROV290cmpXWFljcGhNL1hBTjJS?=
 =?utf-8?B?MCthTDQ0ZmhjdnUxc0dPM3QrRzVsQWZvV1BvSFRPMlRFbHNseGxtYUJaNFZG?=
 =?utf-8?B?SEp1cENZdUdTdWNQVmZ5aDJ2eVBmb2RFbllRMGRiaG1QU1M0TEdCQVVYeGJR?=
 =?utf-8?B?alFuNkVGTkxUSFloaFhsdnFyTmdIcGZFb0w1OVc5OVVyRmhWMkx6YURzMXpu?=
 =?utf-8?B?T0VUMExoNE5xa2I0WWpGamRuN0xzNWxleTVyR0hnT2tvWTdDd0dLQWF2T3M0?=
 =?utf-8?B?M0FiZnB5Y1piS3JCVWJpeUkwTnYyWnZaTVYyRjh1dG55dTFhQ3REbnBOTDBM?=
 =?utf-8?B?S0MzY1UrUWxlQUE5L3NnNUZyVXRhYmxPNDcwMXhZTHNscWQxcytIUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df309b60-349c-4289-58f2-08dea058bb7a
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2026 10:20:10.1364 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uBPLSDfApMmdHxxDwMK8ccXXpD1Bz4kyWqwTGHCEGy2XDaVrPgbGHUPr2hhKS02xu8UxwrQLZ5mJQZjyV0DC1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR12MB9536
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

Now this is exactly how i nearly disabled the reset login in my 
validation setup.
Looks clean and as per the expectations.

Reviewed-by: Sunil Khatri <sunil.khatri@amd.com>

On 21-04-2026 06:25 pm, Christian König wrote:
> Well the reset handling seems broken on multiple levels.
>
> As first step of fixing this remove most calls to the hang detection.
> That function should only be called after we run into a timeout! And *NOT*
> as random check spread over the code in multiple places.
>
> Signed-off-by: Christian König <christian.koenig@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 38 +++++++++--------------
>   1 file changed, 14 insertions(+), 24 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> index 8ce001481d42..5ccd53ad8efd 100644
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
> @@ -1268,7 +1259,6 @@ amdgpu_userq_evict_all(struct amdgpu_userq_mgr *uq_mgr)
>   	unsigned long queue_id;
>   	int ret = 0, r;
>   
> -	amdgpu_userq_detect_and_reset_queues(uq_mgr);
>   	/* Try to unmap all the queues in this process ctx */
>   	xa_for_each(&uq_mgr->userq_xa, queue_id, queue) {
>   		r = amdgpu_userq_preempt_helper(queue);
> @@ -1276,9 +1266,11 @@ amdgpu_userq_evict_all(struct amdgpu_userq_mgr *uq_mgr)
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
> @@ -1378,7 +1370,6 @@ int amdgpu_userq_suspend(struct amdgpu_device *adev)
>   		uqm = queue->userq_mgr;
>   		cancel_delayed_work_sync(&uqm->resume_work);
>   		guard(mutex)(&uqm->userq_mutex);
> -		amdgpu_userq_detect_and_reset_queues(uqm);
>   		if (adev->in_s0ix)
>   			r = amdgpu_userq_preempt_helper(queue);
>   		else
> @@ -1437,7 +1428,6 @@ int amdgpu_userq_stop_sched_for_enforce_isolation(struct amdgpu_device *adev,
>   		if (((queue->queue_type == AMDGPU_HW_IP_GFX) ||
>   		     (queue->queue_type == AMDGPU_HW_IP_COMPUTE)) &&
>   		    (queue->xcp_id == idx)) {
> -			amdgpu_userq_detect_and_reset_queues(uqm);
>   			r = amdgpu_userq_preempt_helper(queue);
>   			if (r)
>   				ret = r;
