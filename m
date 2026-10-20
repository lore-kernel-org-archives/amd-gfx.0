Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03CED606A322
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Oct 2026 16:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=PT0DTARN
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9AAB610E796;
	Tue, 20 Oct 2026 16:59:03 +0000 (UTC)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012054.outbound.protection.outlook.com [52.101.43.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 94C0010E796
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Oct 2026 16:58:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=htYM/wkjLT3BtDlimaduKApFoAK977cPNL7fYReyQFDMvJD92MpAOV1O0Z2X5zZiAFfoVBD+2E0Ik1eGgaGyQQJ8kQ0JtH+Ab0bpDTp70kPxNYAQwmdzZyX5cr1QG9qB7+sytBP/halVorqxULC/ZXr3UCTeiwjs9EJzd6wrQgdYnbRbiftwupydXpYBg/rBGzijRINU8Vn0DhtTzScWaGZIqM7cE/7kAsDUazS8/KPVZotTXdDVyaJEwxdjYLT/heilVnJfn+qaKTzcd05Ihyuc2HYa/JmaFixyBgeiStz54NtuZK2LzeEyT2VNMUK9o3fgt/c4qpdih64jJnp0Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=In4qkQke8gKKkhS9Iy9sha51uBROaMsZ1h0549zweCQ=;
 b=VmyGwdHaVZldkFdM9n0G+zFKJ7ty4INGVNPgComIOqNyOBVRkFr6x/IF2atNF9DVaivMzbe1e+RQ0pqV0cCtimSYXjEfgr3/pfy7Hd3HVu/ZGNnGoGDfotJJR5orF9gyI4DcN784gHUafIzmvTo1Umm1DT4ibLXbiOi7GHnHkH/pWRXPBA37RaPKLMTY509oFkx+f0Rwatj+AkoVfGXzJ3X33PZRslMLEaJLxw0gb2YF3TNEPsg3MWuTIuIPfIwtfjWCgOxvQqBq0LIsdv8MC0t3OmLJijB1kFek7daT4xVOBR/TyQhgU12Igcwfg0C2MQUwkRcajn2AWq7tS+Hcvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=In4qkQke8gKKkhS9Iy9sha51uBROaMsZ1h0549zweCQ=;
 b=PT0DTARN+cWy3/TpOgms2P1GZVQ80JGUmpPcovZth+w6CSZSkf8KHP0bqvc9M1DcuDmwgTOUQcR77TCYkZMDOxh8ewOf/crZlDOqkRUn6HJ6jM5K1e8QlDqGBzwB7GdoAgmHk3nkFVlHUzseiD0PxowaKDvkZU9ZNC/NQ+jW22c=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS5PPF78FC67EBA.namprd12.prod.outlook.com
 (2603:10b6:f:fc00::655) by CH9PR12MB721654.namprd12.prod.outlook.com
 (2603:10b6:610:339::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Tue, 20 Oct
 2026 16:58:54 +0000
Received: from DS5PPF78FC67EBA.namprd12.prod.outlook.com
 ([fe80::23fd:d049:8f53:2054]) by DS5PPF78FC67EBA.namprd12.prod.outlook.com
 ([fe80::23fd:d049:8f53:2054%6]) with mapi id 15.21.0522.017; Tue, 20 Oct 2026
 16:58:54 +0000
Message-ID: <85cc0b33-ad09-4433-a91b-fb603c239780@amd.com>
Date: Tue, 20 Oct 2026 12:58:53 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/amdkfd: Back off SVM restore work retry
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20261020163116.1069749-1-Philip.Yang@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20261020163116.1069749-1-Philip.Yang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT3PR01CA0098.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:85::9) To DS5PPF78FC67EBA.namprd12.prod.outlook.com
 (2603:10b6:f:fc00::655)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS5PPF78FC67EBA:EE_|CH9PR12MB721654:EE_
X-MS-Office365-Filtering-Correlation-Id: fcdfbe4a-51a1-4989-e872-08df2ecb6c59
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|10067099003|22082099003|18002099003|11063799006|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: Gp9Qn48rsvPfy79VLgVyNCeDnO9UZRPWFWrnA+csJW2+k7ifhiLXmmbakSu3adwsOQIjK6OZQPzAWZypd4J4ctOwzbLY/agWkJPn3JZjBrUri/l8SKRqqSuVlvJf31cDhazz/bLiDOG/cuCpsKDe12KsIussaHGc8GSCL/BRRk5+DBl8s+5WkJAhIXGtyqTgXF0EbVf0vZEpCxKcflHk8ibC79EI5Ji+vWk5+4LFH7Mx5S1M8FN77E2Jb0UFxgOjg3JMLPcXVVW1lgYT0DQli34nI1MXhDst6XUSVS03VjS09MORGUAj9hWALVmgy0dFksJEMb3+Hc/u4abWKgpZtGa/gw+ylKqw3wcL59Vo4z4o0cbgpmWluZbsjsq8fCc9ZeUdjcBBUfVjh4ihyTWZ6+chSDLghtMb6dvoUsIYITUj/vLD7fAiu8m02jmSZsHBgoXaCXmLsPvLrUC+K1j/MwMw1Ckw5XW97uc3BWHu5tWTMcAtfLGrhPweDfMY3NniCyHv9pUSejmlvzNj2CjcRrG6XY2JDZMVWLVeqOf9Yznv2pXeb/d8d04UrUDIPMOVgSp9NamYzOlr5y+mK5nS9gFchXm8cElt+J6U/Gpq7Xh3H1mDARZXDCrIqRGKnHjpd+659fOoCY2fwv5fR1AX4UaJAbUQhtIALxQYRg6pX34=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS5PPF78FC67EBA.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(10067099003)(22082099003)(18002099003)(11063799006)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T3lTSnBZOXpIam8wWGNaeW4wMDY1S0ozeWRrZ29XVEZFMXZQSytKS0pIMlMw?=
 =?utf-8?B?VWRQTERVek9JandIWVFtbDlvWEFsNS9qZ2cvWFJaVTNKK2ZydExnTnRBK3Fx?=
 =?utf-8?B?aVZPaHkvNU9JUjZKV1VsNGt3WkhiVGRzRTFkNVoxdVc4bHZnY3M2S2Ryb2RG?=
 =?utf-8?B?dVVlSWpEcmhJRG1EenNyV2tRV2pGMzM1S204SkxxNm1wS3RkdXljZHVuZzBr?=
 =?utf-8?B?dEFRUlk3NFEwZERWM1M3TkcxamhwcWVONFFycjdGMlhqbmhodzFXWTFrY3pY?=
 =?utf-8?B?QmJiektpTC8vM2pFOXdpMzcxVUd5K0psZ2pGS2czY29iRStvNjkvdzFJMzBY?=
 =?utf-8?B?TDhWc28yaWptaGRnWE9jZml1TE4vY0lzbTh0QXpKNWxTTTVRcTY5WllUMnVy?=
 =?utf-8?B?ODBZR2EyMUNZdm1qcHNvRElUMjBXbmVvdTN1WFRnNzFpQWFnRmljaDhhNEZt?=
 =?utf-8?B?M1RKMzhtWjd2Wk8rYkhZV0xBZVQxcEx1NUZSRURoQjE0VnN0N2ZIWEk5YjIr?=
 =?utf-8?B?TGJyNlNCOWNwZ2xKV0wzTWdMZkgrQ2xiMnFVc1gxSnptSFNEOVFZKzNZcW9m?=
 =?utf-8?B?Y1JLSU5XZlRWQW9QMmJGNkpOQi9KcjZGQkpoaEdpQUoxcXdGamVDSWVrdW13?=
 =?utf-8?B?dDRWSjMyUUM1ZVl3cW9tU1pCMUZVbzByU0hpdUFUb3dMUEVyMDVKb1p4QmM3?=
 =?utf-8?B?VHZuU0NEWG5XL253aS94eHArVjdNVEVJVFgvbmZPUHB3ckY0emhoaURZZ284?=
 =?utf-8?B?UVhPQkFwNVdOcjJWUzZVdlFFdGRZTk4wTllYemZpUGtnQTVTSTBXdVpPSFgz?=
 =?utf-8?B?TUJzNU5YMUNmbmNRY25zSGx1YjBlZHlHSFE1bzZaMFFIekpMSisyQlNNNENr?=
 =?utf-8?B?MmUxZnVtVVJVb05YWDdqbXErNnBBTG9DR0JidllwSEgzYmZVSk9IREtoTVgw?=
 =?utf-8?B?Q0Z0QkI0N3pPamtETU5RT3cyNkk3THlpb0lIZmdFaWg1TFl1UGVjK2xGS2Nn?=
 =?utf-8?B?b3RsR0tpWGMxcWZMcnJIWExIdDdOZFJiZGd1SEU5YnF6a2lxTFNkUEh1K241?=
 =?utf-8?B?bnJ4YUJKWXJBUTBLb25TdWMvSWgwczB1ZFlNUWEreGRHd3lYVWh3VDVkeTIx?=
 =?utf-8?B?V0taUFNsZEFVYkxJWm9YTHF3K1haMjlzci9DWEZKQURaVDllYUlWYU9lRDhI?=
 =?utf-8?B?UmJvUU55cXNwV1NFcmNQdDBuVXJMN0xPK2J3TjhvV0pzdWY2N2NGRXpkYW95?=
 =?utf-8?B?TEsyQ2dyaTJYb1FGQ2tEMzJEQW5ZL0dGNTJGTTdObUI2clpWMDA1WTRld1B6?=
 =?utf-8?B?dzB3dW5oVGVuc255amxvYjJtaWl1NkhsWnRZVGpOTHlqYnZmM0hvYUVGOHMz?=
 =?utf-8?B?RU00MXh5anF5MVpUTlRkZmtqMWRYKzdGNlgvVmxCYnNzNXN5akNLTGxJdlNW?=
 =?utf-8?B?VTBZZnRuOUhsQ0xabzRHM1VCWm5lTTZTOTI4Y3RuTWdtSXViVDJNQnMveFJ6?=
 =?utf-8?B?RTNTSWQ5WXY1dFJmdFFnUm5MQmNmMmRjbFRVYkg2RkxTd1ZmT242VStLanoz?=
 =?utf-8?B?UlBHMmZWb2s1dFpzQzBkZVEwNE85dEtWc1lkcTZIbFQzUjRCMWFRamlBbXdQ?=
 =?utf-8?B?dWNmVGNBK2VzR2ZXUWtEaXEvM3RubFJrZ2FrdWJLNkRETVFoRWhJeGY1TTVN?=
 =?utf-8?B?U3BqY0ZTdnpVSG54eUdVN0NURkRMUm5QaWIweHJoMkNPQ0JzRmgvdmhDdkpo?=
 =?utf-8?B?dldLbkxrNHQ1UzUvbmJuSEZ0ZHBFc3BjT3M3aHhoY29qK1RIcnR1SHNjSC9k?=
 =?utf-8?B?cm83S3lwOVRKT2FQSjdrZDBsTzNqaG1DWlpPYVB2dUoxbE00RWdmamR3Z2hH?=
 =?utf-8?B?MTR2cVp2NDM2WWhidUZFa2lGNi9Gb1YvUWROWU9FZzVocHUrUVZ2V3VzcEhu?=
 =?utf-8?B?bDhLZm1VYjloemZoSjY1aUNsb0tETldhQnV2RFdKdkRNUDNUMlhMbmpWSUlt?=
 =?utf-8?B?bzZsSFJUNGJUbit5Q2VCV1hFRTdpUWQ0RlFiZEk5SnFDWGhKSFVxeFBFWi9n?=
 =?utf-8?B?RzBSbUN5TU9GNGg5blBqQXRYSElaN2ZsdDVXc1ZCdm94TFUrN25WcTlMZTdD?=
 =?utf-8?B?eC9nc3EwbVJ5TlBTYTBEbUNybzhQUDZES3cxY0l6bnJKV3ZPWkhCSys2cTY3?=
 =?utf-8?B?SjFoQStiZk1RQ0FlNUhmUnR1YnhpRStKQ2Q5M2xUTjlqdEhiTkFnK0V3UVdh?=
 =?utf-8?B?bzB2NWVkdUc2Q05TaWduZURWSFlVMk9jV3UxYXBXeHZWRnpYNG94c0Ewbkk3?=
 =?utf-8?B?SEMxN2NUN01HSFJvb0F3U3RaNk90cUQ5MmlpL2RmeExNOS9UcjJUZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcdfbe4a-51a1-4989-e872-08df2ecb6c59
X-MS-Exchange-CrossTenant-AuthSource: DS5PPF78FC67EBA.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 16:58:54.2408 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2A1mR4KLrAMmn7BP7u63NUmgsSLK0SeLLOlu2aR3X+CKbM1AvXnikXZUb03HCYpr2yDsTVzPYO24mFaV5oKG4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH9PR12MB721654
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026-10-20 12:31, Philip Yang wrote:
> svm_range_restore_work retries every AMDGPU_SVM_RANGE_RESTORE_DELAY_MS,
> 1ms, as long as validation keeps failing. Each attempt takes
> process_info->lock, the mmap write lock and svms->lock, so a restore
> that cannot converge, for example while memory reclaim keeps
> invalidating the ranges, starves everything waiting for the same locks.
> svm_range_set_attr cannot add a new range until the retries stop.
>
> Double the retry delay on each failed attempt, up to 128ms, and reset it
> when a new eviction cycle starts. Retrying 1000 times per second does
> not help a restore that is failing, and the backoff leaves gaps for
> other users of these locks to make progress.
>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h |  2 ++
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c  | 16 ++++++++++++++--
>   2 files changed, 16 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> index 4ba72c6069e5..8ed25a92cd89 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -1060,6 +1060,8 @@ struct svm_range_list {
>   	atomic_t			evicted_ranges;
>   	atomic_t			drain_pagefaults;
>   	struct delayed_work		restore_work;
> +	/* Retry delay of restore_work, doubled on each failed attempt */
> +	u32				restore_delay_ms;
>   	DECLARE_BITMAP(bitmap_supported, MAX_GPU_INSTANCE);
>   	struct task_struct		*faulting_task;
>   	/* check point ts decides if page fault recovery need be dropped */
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index 40f5b2ee0cfd..28b687133cf8 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -46,6 +46,7 @@
>   #define dev_fmt(fmt) "kfd_svm: %s: " fmt, __func__
>   
>   #define AMDGPU_SVM_RANGE_RESTORE_DELAY_MS 1
> +#define AMDGPU_SVM_RANGE_RESTORE_DELAY_MAX_MS 128
>   
>   /* Long enough to ensure no retry fault comes after svm range is restored and
>    * page table is updated.
> @@ -1964,6 +1965,7 @@ static void svm_range_restore_work(struct work_struct *work)
>   	struct mm_struct *mm;
>   	int evicted_ranges;
>   	int invalid;
> +	u32 delay;
>   	int r;
>   
>   	svms = container_of(dwork, struct svm_range_list, restore_work);
> @@ -2034,15 +2036,23 @@ static void svm_range_restore_work(struct work_struct *work)
>   	pr_debug("restore svm ranges successfully\n");
>   
>   out_reschedule:
> +	/* Back off on repeated failures, retrying at the shortest delay keeps
> +	 * retaking the same locks and starves everything else waiting for them.
> +	 */
> +	delay = svms->restore_delay_ms;
> +	if (evicted_ranges)
> +		svms->restore_delay_ms = min_t(u32, delay * 2,
> +					       AMDGPU_SVM_RANGE_RESTORE_DELAY_MAX_MS);

Why not do this inside the "if (evicted_ranges)" block below?


> +
>   	mutex_unlock(&svms->lock);
>   	mmap_write_unlock(mm);
>   	mutex_unlock(&process_info->lock);
>   
>   	/* If validation failed, reschedule another attempt */
>   	if (evicted_ranges) {
> -		pr_debug("reschedule to restore svm range\n");
> +		pr_debug("reschedule to restore svm range in %u ms\n", delay);
>   		queue_delayed_work(system_freezable_wq, &svms->restore_work,
> -			msecs_to_jiffies(AMDGPU_SVM_RANGE_RESTORE_DELAY_MS));
> +				   msecs_to_jiffies(delay));
>   
>   		kfd_smi_event_queue_restore_rescheduled(mm);
>   	}
> @@ -2117,6 +2127,7 @@ svm_range_evict(struct svm_range *prange, struct mm_struct *mm,
>   			pr_debug("failed to quiesce KFD\n");
>   
>   		pr_debug("schedule to restore svm %p ranges\n", svms);
> +		svms->restore_delay_ms = AMDGPU_SVM_RANGE_RESTORE_DELAY_MS;

Is this the right place to reset the delay? You can have a lot of 
invalidations happening that cause failed restores. So that seems like 
the wrong place to reset the back-off that's supposed to solve that very 
problem. I would think the delay should be reset after a successful 
restore, not after another invalidation.

Regards,
   Felix


>   		queue_delayed_work(system_freezable_wq, &svms->restore_work,
>   			msecs_to_jiffies(AMDGPU_SVM_RANGE_RESTORE_DELAY_MS));
>   	} else {
> @@ -3420,6 +3431,7 @@ int svm_range_list_init(struct kfd_process *p)
>   	INIT_LIST_HEAD(&svms->list);
>   	atomic_set(&svms->evicted_ranges, 0);
>   	atomic_set(&svms->drain_pagefaults, 0);
> +	svms->restore_delay_ms = AMDGPU_SVM_RANGE_RESTORE_DELAY_MS;
>   	INIT_DELAYED_WORK(&svms->restore_work, svm_range_restore_work);
>   	INIT_WORK(&svms->deferred_list_work, svm_range_deferred_list_work);
>   	INIT_LIST_HEAD(&svms->deferred_range_list);
