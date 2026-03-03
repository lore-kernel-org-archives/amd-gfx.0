Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59526E67A8D
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Mar 2026 08:01:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D6E9010E009;
	Tue,  3 Mar 2026 08:01:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vbSkMd8D";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011035.outbound.protection.outlook.com [40.107.208.35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7EF1510E009
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Mar 2026 08:01:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vDmmGZkW80KKjoNjKHJkWYzeCMuoePfae435oz2beODq1esUADHVGSqgizFJK1mRmMQN1RbBe5N02FUdbC8ipTYUPxZRe2w6808QULf4toJ0GSS3lY18BEuTPdpUZDG8TZlXTNi9+40K9RI7OW0FsNA+R7be213hkFhSyA5+Vm+ocn20U20HYHnSypkfELbDkK2ya87QbJDb/PvwniYZg1i/Y7znN2MbF3VidqBem5+5y/95lVBzM+aeqXFRwcin4mNUCzTXiDzoyTfSLDeXQXjD4/d0TCEBcjVBEGEYTSc87Kx9QkXm/pnVpNs+JpWO7KUWE36Mq0Ph5NW+aU9Ehw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RvRTpyIVn6ZqWIvjM9WNMg5VtVPtkusYFSsVQN0OXpQ=;
 b=jDzuo1kJlOhyZ2meDiac9MNHv0PnRVdo/zAFDbkwCiKi0SbCtHFhtHywXFuVjHbs0QVX09FTpjZdc/i7ksqfMygqfxP6rRF55bAGB2eWcCVu7hin5HHTzZYfzDOI+KQMQJErecHr4cWE+DXwk1+AjY0paUaI+6dQVWJp2ZLGPrvSb9tJ54X9O5Z0Qi53HfilINsw9QtIMn9iqZJ6B7FDSR0qyMcGOAJrb9U9jgQWl5kvLLcCx3bbgI+bLz+cC9P2FjE4ORp3lxHe7ShjMSF1AWC6N8lKcLuia5DUwR7WwCdXVBX3Atm1HiaLQ6tRQYmOxXuu6QFGT00n9Uu79Q0ypA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RvRTpyIVn6ZqWIvjM9WNMg5VtVPtkusYFSsVQN0OXpQ=;
 b=vbSkMd8DrJzF+U6TiP784ALR1sRYDumoFh7WyyS9whRWt4nsM2qj8DekKjQ7OGxSojCPY3ng0KdDrwdlqUQNMiqwSb5jbljmo3yzl0DiHR9t3hT6+PYP3WFpI+GYNQ4/jBrkP28/D6bXnnaQ4WkLi98cX8/c3BgquIxh+QyPlno=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CH2PR12MB9493.namprd12.prod.outlook.com (2603:10b6:610:27c::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.21; Tue, 3 Mar
 2026 08:01:46 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9654.022; Tue, 3 Mar 2026
 08:01:46 +0000
Message-ID: <fd68e701-a6c9-4533-8d03-045c3e2c7231@amd.com>
Date: Tue, 3 Mar 2026 09:01:41 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] drm/amdgpu/userq: refcount userqueues to avoid any
 race conditions
To: Sunil Khatri <sunil.khatri@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260302180852.1344171-1-sunil.khatri@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260302180852.1344171-1-sunil.khatri@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0131.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9e::14) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CH2PR12MB9493:EE_
X-MS-Office365-Filtering-Correlation-Id: e984484f-4980-46f2-d937-08de78fb1d61
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: r7k7yHgnZHNuEhhODM8VJ8EAkqENv3w+ig9eCo6Yr6Z25c79xE9z9hpKkCGOakMlZLOAH+XkThn8lrAWNJDg51z4rVPlLC9JCCzhHhUp1yz4+8MLI9JNY4lLFM7EwKXiWSKG+bCiyLGyjZwow0w1SEySkPnbLALhv/9flV1j7E+1LTB+DZWBb7uOSfo2jbug1EQaoL0oAa8AVHmO6keY+AmP/JB7HC9kA38SrZ5rvdsvSb/FcsUdI+15ZgOozzlR+QOWtMOs4915qINzZCOGhx4Pg6u5QJesu/R+ym8pooyZRDTGYhcfL9FccEi6Fs6wKPEIjvZeAHfoFIwuarycQOyFX7TZYJgPBMO79izB5b+TPJelubv3CbtTNcdXCgsCvKN+A+Vu89D0mDODUW9+1vzZNgRamZXQ4FUGD1RjuS/IIbGRpbpWT3dqOg2TDa39Hf8hHbNcjV6bFWOn8qzUKLfWwR5PckRNIE3jrSRis4dUub3Zks831IcWwMjv6jHFW7BpVOKuujL+6ZARd/dO96VhPhsZpmSBMvo/5BTQlG8iecWExRdUUm/J62kiRbeGpwQaehdyb4teQtc/7NnalVHKs8tuOb8uRLc0jpdjK824Yva2uh+T9K9yyjzLDhnfUbiRwZXuJVvUg4gdGdWAAj2rV1Bip2saZeZNvIMJEyB8Du7Q+Zh/pw9QWqGJLFO0TGB/tVrrPipCP6EroIhotzt557WNseNlJ8/PDjZf9zA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ekNRTEpMWnpjeXF3VU5xZHdaVndwMHNsOHNaM2l1RVVMbFRqRGM2aVdSUEhj?=
 =?utf-8?B?REFOUXozVGlkSHNrd05tcGVHUkVBck1Hb3hXMStpYWZvdVNSenJPY3V5SVVP?=
 =?utf-8?B?OVJPYzVTMXdYTWZIVlNkSGxqQTNaQlc0Vm1ldWlZbWlMVzNmbmtZaHYyTUlo?=
 =?utf-8?B?TWtMOGVpTmtrTG1pa3NzMUdPMDU4NDJwbGI3ZmxEZXZGK3U4Vm1jdllpSWVZ?=
 =?utf-8?B?eTVFODZyV0JzWWpESXpWUXU3Sk0yUkphbUs0VzJDZzVnNG12SjJHTCtodjdJ?=
 =?utf-8?B?MHFDVnpUTlhBYmhKdmlzNFVFYkxBZTF1azMxVWwrVDRRVVZMaGlxWDRXTVY2?=
 =?utf-8?B?eENNQUZwQm9BRVVSeVBuclBjN2JLS2ZCTzdkQTZES3FLMDF1Z3l0bWw5TmZW?=
 =?utf-8?B?bjFhdWpYMHBDd0w2bG5nWEJoS0xFMWJkSE9LYWRKczdxQ1RBa3VjbTE0ZWpP?=
 =?utf-8?B?Y2JJRUpWRHA2MGpFMWpDejJHUlo1VXkxaE51NTNWaGRaRWQ1QzZPRjlSL0tw?=
 =?utf-8?B?VSthV3RsNloyYXRSaXAzbmc3ZFY5THlMd2tYUEswK2kxK1d1eW41Z0ExZk1l?=
 =?utf-8?B?dGdqTTdLRHdIWE1ZeFdUVDVBSldHWmlzNXdycjNZOXhYeC8rcUdnTk96Y0Y4?=
 =?utf-8?B?aEY2aGxRUDNnc2Q0SEJic09IakFHbEhqeFBCcXJMTDZHbDR5WGxQSTVKTXNL?=
 =?utf-8?B?M3J2Y1E0dzNyQTRzMk1GQWE3U3hQR1ZuWGs4ZWdyR3RhQWFKL1B0cnNLN1NI?=
 =?utf-8?B?YUVPMGtiRWt4YjBMTUswQ3VSUzdScElaZEthMU5jOFhCMnVIS3RRMFBPa3pM?=
 =?utf-8?B?UmhBNFJzMWlTclB3RDU3ZjZNNm83SThyZWhwdEc5WmRuUDBhVnlqSFFWN2FN?=
 =?utf-8?B?R1c0VDVhekMweGp0U3JjWm10cWVlUmwraXpOZFFJRzBZTkRHdWQ2aW15WWxt?=
 =?utf-8?B?VG1SSFdHeVp4YlY3Q21kVWViUkVrU25kdnRvVG5YOTRURkFobWF0blcyWElu?=
 =?utf-8?B?WUwxOGErZ2lHVTRrNDRvRkx5em5qTG4vaENWTlhMWHg3blprQmlQNVF2YW5R?=
 =?utf-8?B?MEkzYVpianR3UVl6N0ZycnBvZGhNdGVacGhNQWI2enBBNlV4MVJzQTJURkY4?=
 =?utf-8?B?MUVReFExVzU4aVJnWGlXUXJWanNFWkQyOUNVMWlBLzJsVGV5ckVBWmZjcGNI?=
 =?utf-8?B?dVgyaTFFZEpPa0pFVlNGZnlQcmo2N2lTZXlIeUFtejBHTDhPQVNET0lRek9y?=
 =?utf-8?B?cGxvbnBkSHhEeWc2M21nK0hkOFRjOW9Hbi91OUtGVG1XRmFoOGtBQnhVSy81?=
 =?utf-8?B?b3RtOU0vQ1UzWW81R0habHN4UDdRUTUraWV1RXNsUEtkVG5JakZGWlNSaFY0?=
 =?utf-8?B?ZzducGE2Nzg1T0hoWG1tQ1NYakcvcEpVS251RXV3LzB2SmFzVjNTM3Vvb1M0?=
 =?utf-8?B?Y21YWmhkTnhBMUgzMU5VSHpGTGdGZktrMjBqUGZZMWU5VkEyMmYwbVMrUFEz?=
 =?utf-8?B?OG02YVVYTWJoeGpNM1NnU3ZvWXJ2WitxQUdTOTVNR0NVditpTkJVVFZHYkQy?=
 =?utf-8?B?SFFSKzJyd29tYUl3SDI2bGt6ZkNCc3dsRW9TYVZIK1NsTExrT3BYVTBVZ0Fm?=
 =?utf-8?B?VEVvWGJFTGk4UmdrWXJPMFBVbW5xeDJtS0xYRDlzTXNibWMwQUVRbm9YUnN1?=
 =?utf-8?B?cGNDcDVrUU5IQlo3QTJKc1IyeUtHK3EvNDFJR1ZzdTRyMDFBVzBNYUFVMmhV?=
 =?utf-8?B?alpMUCtrYkRmR2V2MXRMVm9UM2xHTWVkeG95enk2K25FSW91djVXUFZzWHFu?=
 =?utf-8?B?d01PMjEwZTFuazlTQ2Q2QXFZVHlxT1Njb0NXMmZHbDNtL0RTZ0Z5ZGpaSDRa?=
 =?utf-8?B?ZHNXWDNydTN0MDVXbGRvV1ZWRHdGcDRRV3V5RWVSWTNWWWhjSDl4RTZ1MUJr?=
 =?utf-8?B?eUczMlVCc29uaWhLWXlHaFZ4NVBRczVMQW5nZ2dDOFBWMmJaVmNRckpzUFdC?=
 =?utf-8?B?eGp1WnRTWkxjcXA1c0dSdm1ET0RGTDE5OHhLZjhKeTZDMC9FZU92OEpLR2RI?=
 =?utf-8?B?d2NMMnBQangwQkFMTGkva1k3eUx2TTJ6bllDU0R3SXhyZnVwS0E2bzFWVzQ4?=
 =?utf-8?B?dys5SVpJakI0Y05HVUgrNVVnNExoYzNWNHlYNE9oU3YyenQvNDNWRHU0OEdD?=
 =?utf-8?B?Z3E2dlZUdkdDQkVOODVSQS9ENFdZOFRXd3BXN1U5OFU3U1lWV3NKazF0U2k1?=
 =?utf-8?B?MlZtVTAxZk1KVTlzMFdXdDh4elIzWWk1b3dNcUYxMmxxRXpRTmxpNzFxbVNK?=
 =?utf-8?Q?qgoT1+eNutxvGJgbIu?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e984484f-4980-46f2-d937-08de78fb1d61
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2026 08:01:45.9763 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A1CxXLec62euiBmJ+yuVkQbAoJtWrOV5918DkLSFEGLQLcSpY3XhCSAAIIIMEgOY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB9493
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

On 3/2/26 19:08, Sunil Khatri wrote:
> To avoid race condition and avoid UAF cases, implement kref
> based queues and protect the below operations using xa lock
> a. Getting a queue from xarray
> b. Increment/Decrement it's refcount
> 
> Every time some one want to access a queue, always get via
> amdgpu_userq_get to make sure we have locks in place and get
> the object if active.
> 
> A userqueue is destroyed on the last refcount is dropped which
> typically would be via IOCTL or during fini.
> 
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c     | 85 ++++++++++++++-----
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h     |  4 +
>  .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   | 10 ++-
>  3 files changed, 76 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> index e07b2082cf25..bd62c95eeaad 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -461,7 +461,6 @@ static void amdgpu_userq_cleanup(struct amdgpu_usermode_queue *queue,
>  	uq_funcs->mqd_destroy(queue);
>  	amdgpu_userq_fence_driver_free(queue);
>  	/* Use interrupt-safe locking since IRQ handlers may access these XArrays */
> -	xa_erase_irq(&uq_mgr->userq_xa, queue_id);
>  	xa_erase_irq(&adev->userq_doorbell_xa, queue->doorbell_index);
>  	queue->userq_mgr = NULL;
>  	list_del(&queue->userq_va_list);
> @@ -470,12 +469,6 @@ static void amdgpu_userq_cleanup(struct amdgpu_usermode_queue *queue,
>  	up_read(&adev->reset_domain->sem);
>  }
>  
> -static struct amdgpu_usermode_queue *
> -amdgpu_userq_find(struct amdgpu_userq_mgr *uq_mgr, u32 qid)
> -{
> -	return xa_load(&uq_mgr->userq_xa, qid);
> -}
> -
>  void
>  amdgpu_userq_ensure_ev_fence(struct amdgpu_userq_mgr *uq_mgr,
>  			     struct amdgpu_eviction_fence_mgr *evf_mgr)
> @@ -625,22 +618,14 @@ amdgpu_userq_get_doorbell_index(struct amdgpu_userq_mgr *uq_mgr,
>  }
>  
>  static int
> -amdgpu_userq_destroy(struct drm_file *filp, u32 queue_id)
> +amdgpu_userq_destroy(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermode_queue *queue,
> +		     u32 queue_id)
>  {
> -	struct amdgpu_fpriv *fpriv = filp->driver_priv;
> -	struct amdgpu_userq_mgr *uq_mgr = &fpriv->userq_mgr;
>  	struct amdgpu_device *adev = uq_mgr->adev;
> -	struct amdgpu_usermode_queue *queue;
>  	int r = 0;
>  
>  	cancel_delayed_work_sync(&uq_mgr->resume_work);
>  	mutex_lock(&uq_mgr->userq_mutex);
> -	queue = amdgpu_userq_find(uq_mgr, queue_id);
> -	if (!queue) {
> -		drm_dbg_driver(adev_to_drm(uq_mgr->adev), "Invalid queue id to destroy\n");
> -		mutex_unlock(&uq_mgr->userq_mutex);
> -		return -EINVAL;
> -	}
>  	amdgpu_userq_wait_for_last_fence(queue);
>  	/* Cancel any pending hang detection work and cleanup */
>  	if (queue->hang_detect_fence) {
> @@ -680,6 +665,38 @@ amdgpu_userq_destroy(struct drm_file *filp, u32 queue_id)
>  	return r;
>  }
>  
> +struct amdgpu_usermode_queue *amdgpu_userq_get(struct amdgpu_userq_mgr *uq_mgr, u32 qid)
> +{
> +	struct amdgpu_usermode_queue *queue;
> +
> +	xa_lock(&uq_mgr->userq_xa);
> +	queue = xa_load(&uq_mgr->userq_xa, qid);
> +	if (queue)
> +		kref_get(&queue->refcount);
> +
> +	xa_unlock(&uq_mgr->userq_xa);
> +	return queue;
> +}
> +
> +void amdgpu_userq_put(struct amdgpu_userq_mgr *uq_mgr, u32 qid)
> +{
> +	struct amdgpu_usermode_queue *queue;
> +
> +	xa_lock(&uq_mgr->userq_xa);
> +	queue = xa_load(&uq_mgr->userq_xa, qid);
> +
> +	if (queue && refcount_dec_and_test(&queue->refcount.refcount)) {
> +		__xa_erase(&uq_mgr->userq_xa, qid);

That here makes no sense.

The queue id should be removed from the XA as soon as userspace uses AMDGPU_USERQ_OP_FREE and not when the last reference drops.

Regards,
Christian.

> +		xa_unlock(&uq_mgr->userq_xa);
> +
> +		if (amdgpu_userq_destroy(uq_mgr, queue, qid))
> +			drm_file_err(uq_mgr->file, "Failed to destroy usermode queue\n");
> +		return;
> +	}
> +
> +	xa_unlock(&uq_mgr->userq_xa);
> +}
> +
>  static int amdgpu_userq_priority_permit(struct drm_file *filp,
>  					int priority)
>  {
> @@ -891,6 +908,8 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>  
>  	args->out.queue_id = qid;
>  	atomic_inc(&uq_mgr->userq_count[queue->queue_type]);
> +	/* drop this refcount during queue destroy */
> +	kref_init(&queue->refcount);
>  
>  unlock:
>  	mutex_unlock(&uq_mgr->userq_mutex);
> @@ -985,6 +1004,7 @@ int amdgpu_userq_ioctl(struct drm_device *dev, void *data,
>  		       struct drm_file *filp)
>  {
>  	union drm_amdgpu_userq *args = data;
> +	struct amdgpu_fpriv *fpriv = filp->driver_priv;
>  	int r;
>  
>  	if (!amdgpu_userq_enabled(dev))
> @@ -1001,9 +1021,7 @@ int amdgpu_userq_ioctl(struct drm_device *dev, void *data,
>  		break;
>  
>  	case AMDGPU_USERQ_OP_FREE:
> -		r = amdgpu_userq_destroy(filp, args->in.queue_id);
> -		if (r)
> -			drm_file_err(filp, "Failed to destroy usermode queue\n");
> +		amdgpu_userq_put(&fpriv->userq_mgr, args->in.queue_id);
>  		break;
>  
>  	default:
> @@ -1023,16 +1041,23 @@ amdgpu_userq_restore_all(struct amdgpu_userq_mgr *uq_mgr)
>  
>  	/* Resume all the queues for this process */
>  	xa_for_each(&uq_mgr->userq_xa, queue_id, queue) {
> +		queue = amdgpu_userq_get(uq_mgr, queue_id);
> +		if (!queue)
> +			continue;
> +
>  		if (!amdgpu_userq_buffer_vas_mapped(queue)) {
>  			drm_file_err(uq_mgr->file,
>  				     "trying restore queue without va mapping\n");
>  			queue->state = AMDGPU_USERQ_STATE_INVALID_VA;
> +			amdgpu_userq_put(uq_mgr, queue_id);
>  			continue;
>  		}
>  
>  		r = amdgpu_userq_restore_helper(queue);
>  		if (r)
>  			ret = r;
> +
> +		amdgpu_userq_put(uq_mgr, queue_id);
>  	}
>  
>  	if (ret)
> @@ -1266,9 +1291,13 @@ amdgpu_userq_evict_all(struct amdgpu_userq_mgr *uq_mgr)
>  	amdgpu_userq_detect_and_reset_queues(uq_mgr);
>  	/* Try to unmap all the queues in this process ctx */
>  	xa_for_each(&uq_mgr->userq_xa, queue_id, queue) {
> +		queue = amdgpu_userq_get(uq_mgr, queue_id);
> +		if (!queue)
> +			continue;
>  		r = amdgpu_userq_preempt_helper(queue);
>  		if (r)
>  			ret = r;
> +		amdgpu_userq_put(uq_mgr, queue_id);
>  	}
>  
>  	if (ret)
> @@ -1301,16 +1330,24 @@ amdgpu_userq_wait_for_signal(struct amdgpu_userq_mgr *uq_mgr)
>  	int ret;
>  
>  	xa_for_each(&uq_mgr->userq_xa, queue_id, queue) {
> +		queue = amdgpu_userq_get(uq_mgr, queue_id);
> +		if (!queue)
> +			continue;
> +
>  		struct dma_fence *f = queue->last_fence;
>  
> -		if (!f || dma_fence_is_signaled(f))
> +		if (!f || dma_fence_is_signaled(f)) {
> +			amdgpu_userq_put(uq_mgr, queue_id);
>  			continue;
> +		}
>  		ret = dma_fence_wait_timeout(f, true, msecs_to_jiffies(100));
>  		if (ret <= 0) {
>  			drm_file_err(uq_mgr->file, "Timed out waiting for fence=%llu:%llu\n",
>  				     f->context, f->seqno);
> +			amdgpu_userq_put(uq_mgr, queue_id);
>  			return -ETIMEDOUT;
>  		}
> +		amdgpu_userq_put(uq_mgr, queue_id);
>  	}
>  
>  	return 0;
> @@ -1368,9 +1405,15 @@ void amdgpu_userq_mgr_fini(struct amdgpu_userq_mgr *userq_mgr)
>  	mutex_lock(&userq_mgr->userq_mutex);
>  	amdgpu_userq_detect_and_reset_queues(userq_mgr);
>  	xa_for_each(&userq_mgr->userq_xa, queue_id, queue) {
> +		queue = amdgpu_userq_get(userq_mgr, queue_id);
> +		if (!queue)
> +			continue;
>  		amdgpu_userq_wait_for_last_fence(queue);
>  		amdgpu_userq_unmap_helper(queue);
>  		amdgpu_userq_cleanup(queue, queue_id);
> +		amdgpu_userq_put(userq_mgr, queue_id);
> +		/* Second put is for the reference taken in this function itself */
> +		amdgpu_userq_put(userq_mgr, queue_id);
>  	}
>  
>  	xa_destroy(&userq_mgr->userq_xa);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> index f4d1d46ae15e..ec3ce485626d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> @@ -74,6 +74,7 @@ struct amdgpu_usermode_queue {
>  	struct dentry		*debugfs_queue;
>  	struct delayed_work hang_detect_work;
>  	struct dma_fence *hang_detect_fence;
> +	struct kref		refcount;
>  
>  	struct list_head	userq_va_list;
>  };
> @@ -114,6 +115,9 @@ struct amdgpu_db_info {
>  	struct amdgpu_userq_obj	*db_obj;
>  };
>  
> +struct amdgpu_usermode_queue *amdgpu_userq_get(struct amdgpu_userq_mgr *uq_mgr, u32 qid);
> +void amdgpu_userq_put(struct amdgpu_userq_mgr *uq_mgr, u32 qid);
> +
>  int amdgpu_userq_ioctl(struct drm_device *dev, void *data, struct drm_file *filp);
>  
>  int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, struct drm_file *file_priv,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> index 3c30512a6266..ba453361d2b4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> @@ -521,7 +521,7 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
>  		goto put_gobj_read;
>  
>  	/* Retrieve the user queue */
> -	queue = xa_load(&userq_mgr->userq_xa, args->queue_id);
> +	queue = amdgpu_userq_get(userq_mgr, args->queue_id);
>  	if (!queue) {
>  		r = -ENOENT;
>  		goto put_gobj_write;
> @@ -612,6 +612,9 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
>  free_syncobj_handles:
>  	kfree(syncobj_handles);
>  
> +	if (queue)
> +		amdgpu_userq_put(userq_mgr, args->queue_id);
> +
>  	return r;
>  }
>  
> @@ -863,7 +866,7 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
>  		 */
>  		num_fences = dma_fence_dedup_array(fences, num_fences);
>  
> -		waitq = xa_load(&userq_mgr->userq_xa, wait_info->waitq_id);
> +		waitq = amdgpu_userq_get(userq_mgr, wait_info->waitq_id);
>  		if (!waitq) {
>  			r = -EINVAL;
>  			goto free_fences;
> @@ -947,5 +950,8 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
>  free_syncobj_handles:
>  	kfree(syncobj_handles);
>  
> +	if (waitq)
> +		amdgpu_userq_put(userq_mgr, wait_info->waitq_id);
> +
>  	return r;
>  }

