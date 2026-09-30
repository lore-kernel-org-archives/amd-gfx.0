Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A839CA5FC1
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Sep 2026 08:39:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 04FE310F247;
	Wed, 30 Sep 2026 08:39:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="aGoQ0+E7";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010033.outbound.protection.outlook.com [52.101.56.33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC00D10F245
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Sep 2026 08:39:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cNpOE8mDbLE8nnruuuUVJRhjwTn28ffHD+8HwDsmn8rDPiqMDVqT8RqL6VGjQOQ+ZJdNu8rBXDz7u0jPpgUMdAUSupq0Ya8ViiQtU5eRTrLSXy0bmt69+CoyhfxlYV56w+r0QyAGK2hoDhnJEvgy0L6LGPcdc8kaKfQKghEn2PKNfkU7iugm8sl3KAy9KkpYqwqTZqGp5oDAMzmvOs4Iyck3m9P5E4atvTrNvBnTHmW841eNIUvMshvrhdUhHPRzIeINfP8W9zS7EjZXi0QvoJLJGx8AiGa+Daf9mD2xqOVBtI37OF58idaqjtOFXeFifCDuHT/gHStHJqT7+EcoFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A0nk8ECY2ovXfzmS2lf5KqeZ0dIpFjA/7Hp5A8+h+W8=;
 b=iGt6f+/zziUXEqk2bya/vNvoAVwEY9zjkLfxQSQYBhodTQcQ/lt6I1mVckxsS+dhFD89tf/KvbeniL4khdcSqLNIYX/fkeBI7KxgwmUq5WcF5pEMerwDBnY8U5Cud5D9EUcCtlYLaNLL5O7HHKwj2UvLU/NsRUuRI/fA0REoXWmuPKaJkEgkOGJJa1oynsGDBFpS5z6yl1TfuHkR9ZWjgQX8UghYA+/Tof3k5x+K17NhYDmZmgV1yHo/jZhnVuy1FDlDleL6Oth/Fv3WZ3kWIiuVqDyfiBYnd406FXWVzczbCo5I8TWcvXTPkELTCzHZKpZfHqPHdFx4RjeQtnGarA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A0nk8ECY2ovXfzmS2lf5KqeZ0dIpFjA/7Hp5A8+h+W8=;
 b=aGoQ0+E7gYbx+Z/EMYfvQ5/fAvK4JVu4+aJC5H91mf/pBTWHM+hnXcjxITkv2EogUFIAhkZcJ7DJlsC4KaMq8WCK5vWf+hTeiQz4lvlM8haF8MIKRjZ3dJvh/t3zl4f2t6UOYCQJZmn95TgTF5TTUaYFoJ8wmTfF3ZjbkbjhndE=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DM6PR12MB4154.namprd12.prod.outlook.com (2603:10b6:5:21d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Wed, 30 Sep
 2026 08:39:10 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0451.022; Wed, 30 Sep 2026
 08:39:09 +0000
Message-ID: <1fdb67e4-1950-4fd9-91db-8b7bb0fd5a1e@amd.com>
Date: Wed, 30 Sep 2026 10:39:06 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] drm/amdgpu/userq: don't publish the queue before
 create is done with it
To: Jesse Zhang <Jesse.Zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, prike.liang@amd.com, sukhatri@amd.com
References: <20260930083148.151311-1-Jesse.Zhang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260930083148.151311-1-Jesse.Zhang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0418.namprd13.prod.outlook.com
 (2603:10b6:208:2c2::33) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DM6PR12MB4154:EE_
X-MS-Office365-Filtering-Correlation-Id: 658f0a2d-7bb3-4233-b84d-08df1ece4c06
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: VaFbQepBT10pvG/LAdWddTq9PensGyOlZz4lL97SiBvqHtpu3OGCBRdPorcyqfOVG4Af9KtVkCCestgsZbe9fxh9Ec/dA4TAqKRtb6/4AGYZQY/W+JJ+HMQXun+/IGtNn70zaPmnBoqLMXG8PMu9RsyDKF+UOWaNzHWfWOY338vLOUi8kfy46SGsLBIexzIbUTpTqkcgFvqgNfGs1/NPHQfopG0w4jIAvkbk8tNK2GhZsYNMLDgo/epHhStcDfcamdk0ZVF399spoE7QDEjTA3UO83eqlOBwZL0ftAdC1QGZtkDv129nB5nWfxCL4qJe1v+KjzcI3vKA/wLMhfZfLBelqH6j2Oudj3UKFhpnT09GxUpJRqmW1O5lGm/zjzEED09l+Mzp+vJQjxA//razjSOBawYOYdu1VYXY3WI6KPsBW2te3ESh1I4NcjVkB4wOA5EP09SHosyvlaRD4C+OI0FgpXf8jkQUqiTBII84DLocPZ9ivI8iEQiSyj3dVMeKEvwURoLFS3Z+rtDHZbUWcuLUmUEeW6Z+BoP3AYeksWm+8lw/BnmKXD3uKALWFAVHmruIvXBgtPNwVoBR65/b7UqarmTrRiEC7y/Olirr+gpDFWFeMW4Rb6pVCypyHq5B/cN3uGC1t3c4ZhT/NTFr6odRZUm15d8BrpvGcGCiZRw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S1gydzl1dE1wQS9rMVZDME45SXkxZjg1c3h6endDZDR5ajhBT01zMXpGK05I?=
 =?utf-8?B?bVlqQUoxa0huRGxiS0tLWFRwNTlmSittekpxWnptZUlKdXFRdnpKNUk3cmJR?=
 =?utf-8?B?YmM3ZkF2ZlpOV09yMjFUMjBnWE5XVDVGc3NYTExTNmJYemVVZlE1a3Y1MHo1?=
 =?utf-8?B?ZkpyOWV2TnpUVmNaZkNnNmxUZlNZTW9DZU1XR2xKS29lQW5lODB4d0lPRUpj?=
 =?utf-8?B?NlFhNE1lQWdPa1VyNnVaTnlzSXRzNmRrUW5maWJIUzhIbExKRksyN2ZyV0tp?=
 =?utf-8?B?U2NGNUNtOVk4QUdSTVNlckt3L1FRRWplbzBlaEhZQ0hGbHh2eTNEaWdKSkls?=
 =?utf-8?B?NENWQ056djJDeHNWek55cXp5MVlLZGNEWHdFTzBrZy9lOHpmQ0pPMGQweHd4?=
 =?utf-8?B?by9Qejc3TFZGNUxUUFFIM0gxcmJPNGNmaU52RFNQU3dzVllmY0k1eCtnbXFY?=
 =?utf-8?B?dE9INFNPZVNabGtqSWRVZ2pRb2dTeHlRRmdheEtnd01rTDhleVdKc0toT21v?=
 =?utf-8?B?TCtEMmFBZGZCZnhVeUh3S3pSc3N1cU5aLzF0T09MVGkrZUhqd0V1Tmhid0dQ?=
 =?utf-8?B?Nktpd0tYUmF4cmdIUTJoK2t2R01ULzdIZ3plekFsdndWcFVaMFZOMUtOdWFa?=
 =?utf-8?B?L2R4LzQ1Nms0bjZFNG43UzNvSjB4M0ZFWFo1RWhpeERJUm5IOEE4b0JJWis2?=
 =?utf-8?B?T2U1ZmF2R0NUVTRveGd5MzRWOU1USWlDakxBcEFxSEN0bk0zUXVCeGEvR1BY?=
 =?utf-8?B?bnBhVlF0ZmMrNGRkR3dsNWFLQUlZb255RnRqS3NjWUdUemNNSlVGdE5KdGhl?=
 =?utf-8?B?SXRWVXd5WkJVVm5VOEFhYkVZUWMvaE82dDg2cUhUc3NtWFh6QXZsamRQRHFw?=
 =?utf-8?B?ZkwvYk1wVVpqbGhqVmZhZnhLY2FkOENFSm82WkZRTTNRMU93WDJ3S0p1Y0VK?=
 =?utf-8?B?TFBpQWg4QnhmSU0vU1FLcHRENEh0SWNKSkphY0NtRDcrKy9SYkwyK092bjBL?=
 =?utf-8?B?TEd2VkJMZ2ZMK09JbGgzZUlCRUdpVlRadk51VGZjelV4eG5pV252Sk5udTA0?=
 =?utf-8?B?U01WQUhTV0VKM2VwK3ZOOCtpYmc5WHc0SmQ2MVV4bDVPRWpJazEvZ2ovS1BU?=
 =?utf-8?B?cTdxVHBCdjZpVDI4N1czYTFJSFpVSE1FTXBQSVhoN2N1YktEOEVQcWNLbktw?=
 =?utf-8?B?MDBIS2txbTA0cGNwREhxUDcyaWRZb3psaW9rbjVhNEQ5QlFndUIyMFdCWm1H?=
 =?utf-8?B?WU5MRGN4WjBYczRsaFNTZXNOUUN4bG5DSWxRUzZBR21mR1QyenMyRkNxY3R3?=
 =?utf-8?B?SFVPRjduc2dnMzFqT3dLa2czaitFUXl3R1RnZmF6S1BhcHpsWk5kNFZRMllV?=
 =?utf-8?B?S0pTZ0dNRXl4cTNQYVd1Q005NW43cHR4NmpWUEs4ampMRjRLd3poSmswSE5q?=
 =?utf-8?B?K3NCcWdLUFVCZ2gyQ29yclRwUi9tcEtDejgrVFNiZTcwd0c0TC9XR1Z6aUdX?=
 =?utf-8?B?WUNIdTV4a1h5QWxHanNUSk1idDM2UUc1U2JBR0F1SDUwVk9ZTVE0S2dhREtP?=
 =?utf-8?B?VU5tU2xyN1Bya1RHaU41S3FjNGpldzN6Y3VLY3lhckhVNDNNMnpCM2lyOTYz?=
 =?utf-8?B?VXVWQmpRWWE3amlkWVlCOVgvelhLVmp5dG5aQTBKWWtZOHNiMVBnTmtGb2Jz?=
 =?utf-8?B?dUFlYWZ0ZWFRcExjYnhCNHk2d1g0Smp1QWdQTllhTkhBVUFjSXd4c3crMmJv?=
 =?utf-8?B?NVJodG8vUjF0ekl6ZGxJVy9VTkdzdGxjYys5ZG9VeU4zalk0aVVBQThVRzJj?=
 =?utf-8?B?WGh3NCtKZWZadEo5OWh5Y3hhTjhwbHc0Wk5HVzZ2b2tHdmpBQWR0OHZvQzRa?=
 =?utf-8?B?U1dJMXIvemJNdFJpQ3BLK3U0YmJhcWlXcGlneVJnRzdRODJjOWIxeUozQ0NZ?=
 =?utf-8?B?RUtHbVlCUWtLSzI1NE9oeGJxMWJFMXA1akVJQml3RFNYbHc2ai9hellKWVBW?=
 =?utf-8?B?cE54TmIyLzNmM1U3V0I1UjB6by8vZHhyem1wVDRoMmNCcFJYNG1YVlFzV0Za?=
 =?utf-8?B?SzZWSTJTTjc3RW5GV004MkFYY212NUhvUHZYTjhEdjREcEh0UGt1bkcvQ01T?=
 =?utf-8?B?TkNNNnkwU2xEOFhoUWcrREtNM01UdjBXckREYlZ6TmRkaG1xQnNrdzVUMnpQ?=
 =?utf-8?B?c0c1WjJVaURVYitSRHoxUHlERFlpVFlCNUtKSWFvR0FEaFMrN1l5VDA1S2dj?=
 =?utf-8?B?SERWT2tPamxjYkt2VlFoQ1FtZUJ5S1psaHZVZ0JIMTVzRm1oY0JHZHptK0tE?=
 =?utf-8?Q?r8UtOqYydOCQ5Ol47d?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 658f0a2d-7bb3-4233-b84d-08df1ece4c06
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 08:39:09.8958 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QJvNwQ5FnTmIgruptxR5enIB8CygXSh1RoWMDLoVFbfTouYEByq2NO4V+DbepIgI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4154
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



On 9/30/26 10:30, Jesse Zhang wrote:
> amdgpu_userq_create() inserts the queue into userq_xa and then sets up
> its debugfs entry without holding a reference. A concurrent
> AMDGPU_USERQ_OP_FREE on the (easily guessed) queue ID can free the queue
> in that window, so create writes to freed memory and leaves a queue_N
> debugfs directory whose mqd_info points to the freed queue:
> 
>   debugfs: 'queue_1' already exists in 'client-137'

I honestly don't see that as problematic.

debugfs has tons of such issues and that is generally ok.

Regards,
Christian.

> 
> Only reserve the ID in xa_alloc() and store the queue once create is
> done with it. Don't let FREE release a reserved ID.
> 
> Fixes: 28cacaace5cd ("drm/amdgpu/userq: defer queue publication until create completes")
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> index 63875761dfac..89e03d3a930c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -775,7 +775,12 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>  	atomic_inc(&uq_mgr->userq_count[queue->queue_type]);
>  	mutex_unlock(&uq_mgr->userq_mutex);
>  
> -	r = xa_alloc(&uq_mgr->userq_xa, &qid, queue,
> +	/*
> +	 * Only reserve the ID here. Once the queue is visible in userq_xa,
> +	 * a concurrent AMDGPU_USERQ_OP_FREE can drop the last reference, so
> +	 * publish it only after we are done with it.
> +	 */
> +	r = xa_alloc(&uq_mgr->userq_xa, &qid, NULL,
>  		     XA_LIMIT(1, AMDGPU_MAX_USERQ_COUNT),
>  		     GFP_KERNEL);
>  	if (r) {
> @@ -790,6 +795,8 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>  
>  	amdgpu_debugfs_userq_init(filp, queue, qid);
>  	trace_amdgpu_userq_create_end(queue, 0);
> +	/* Storing to a reserved entry doesn't allocate memory and can't fail */
> +	xa_store(&uq_mgr->userq_xa, qid, queue, GFP_KERNEL);
>  	args->out.queue_id = qid;
>  	return 0;
>  
> @@ -924,7 +931,10 @@ int amdgpu_userq_ioctl(struct drm_device *dev, void *data,
>  
>  	case AMDGPU_USERQ_OP_FREE: {
>  		xa_lock(&fpriv->userq_mgr.userq_xa);
> -		queue = __xa_erase(&fpriv->userq_mgr.userq_xa, args->in.queue_id);
> +		/* Don't release an ID reserved by an in-flight CREATE */
> +		queue = xa_load(&fpriv->userq_mgr.userq_xa, args->in.queue_id);
> +		if (queue)
> +			__xa_erase(&fpriv->userq_mgr.userq_xa, args->in.queue_id);
>  		xa_unlock(&fpriv->userq_mgr.userq_xa);
>  		if (!queue)
>  			return -ENOENT;

