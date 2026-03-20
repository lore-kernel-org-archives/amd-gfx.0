Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B05B108B8E5
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Mar 2026 09:46:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8DD6110EAB2;
	Fri, 20 Mar 2026 09:46:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="t5+hzrnJ";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010033.outbound.protection.outlook.com [52.101.201.33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2181C10EAB2
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Mar 2026 09:46:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OHIKqqDPtzYbqtdjT5198mCEqXyBTrRHeAk6utVNfCXpFld83vUu08zkcvLYLJfhf9L73OxCs62D/yQC/tF/4ZH1VeEBfCJfhg9Q6BHJQgqQ/FfZ8g6pijPeXodAxpM9h5ANqYSei9wIsa8FwufGe01eLQk614GvDxXXk4mu0qdgppvyU0F0gCarrBHBtr9ZiT9+q9r2mNM3n8A589bfzcL8TzCEaJQYoYRA1kmeLcygRQeYH82/bie61PMwgTIqknwK5rIf0MERAxhKUwGAbOm4OuDjchwSS48xxCe+IyMKpE0ss39PKmZWQhN+jd++j5vDPNmAffQMzWdTBeSbJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lj8rLwRbVkzzLG2b43dI5b62YWqa/G1OLKH6tPjdOjQ=;
 b=wuuy19Sg40SMj3sqkO253prDnV23eY2s/dtig/YgJmjxDOWPTKtYR358o9GhwhSWYAqiMD8Us2Wi3TLpGzHgl24uE/60U5yBIinm/a/7QnStgksqogo4x8OBmIWXr5fkby/4/x6yWWaZT4mKIZN7DQsdSHkehwRO3xdCxQ8tIfiLDga3hBB8s/wiWaXrU/1criW1J8F/TZOSP14EdoQrZZnThw4agy7BHv6nEgpsArI/dj6YpyTKvouPRf5akuhLc0qFvg1zLmNEAuFgcw1/cwgzToQtDu/7auigkZCpEsD29/H8fRqr1k9vz5TPBRxjljwVDA5uyRmlbdEPAZWADg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lj8rLwRbVkzzLG2b43dI5b62YWqa/G1OLKH6tPjdOjQ=;
 b=t5+hzrnJMVW+6aBT5Buc5Lr5steYkkeNvb8uA/l6WVmlnIaxhmzBjVyeCLBqdGu0E449ymvVpAmM2bidbYxWiX0xB6nb00jJCPmE/p1BkhgYOf3dOLYuoSjTn/01pIQxPGdLGfJBexZ8W6DAcKmQQPss/LpPxlBMTLZ84icF2a4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by IA0PPF89A593F05.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bd8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.16; Fri, 20 Mar
 2026 09:46:36 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9745.007; Fri, 20 Mar 2026
 09:46:36 +0000
Message-ID: <df195a01-e228-4f14-9e20-ecb63dc9d653@amd.com>
Date: Fri, 20 Mar 2026 10:46:29 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu/userq: add mutex lock/unlocked version of
 amdgpu_userq_put
To: Sunil Khatri <sunil.khatri@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Liang@rtg-sunil-navi33.amd.com,
 Prike <Prike.Liang@amd.com>
References: <20260320094111.3640176-1-sunil.khatri@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260320094111.3640176-1-sunil.khatri@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0176.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9f::14) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|IA0PPF89A593F05:EE_
X-MS-Office365-Filtering-Correlation-Id: d17538fc-cc77-45d7-5e2b-08de86659398
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|18002099003|56012099003|22082099003; 
X-Microsoft-Antispam-Message-Info: S9Bj2WwoHTHCLA2svUhnDIBYvvANfXK/XymqvJ+WKc9VRYwYBE8QcjiZCm42sDh0Mzr0OF+jgdEqsmUuJXbbOZSQCCqLvHY9p27ML8qJHr8CUfoq681Je0BsYUJy777vQlwDTQouXLJ9AtHEodrFGZ2c8SC9Mch4vmO9a7fKbiXDtkQfGHYgrh0fOcDnPStEoPi7ttoqFJnxTbQYX4h2PCDUEUODmcJYxj4EU5mQN1GLzsrXruRBDFbv8/kXvpjt87kQlXNswU1Z1FUg4dnp9UpUrBV4Yp0w/zELN/uT/K3SY6adWmOsboBdmB1o9kXZmBYO+1y7b5/jXas+rY0iNK2m+pi6+f2/m6tyA2lhY1+R+Io5BVWHG7JjkmGX9rNbXqZtr1ojE7iDTBGHjiqy8ZBatYNCgMLnw1q4pWszADxGcYv+yeZDUL1wdWn4JkiB1S+tRqpZgygHXX62kCh3x6HFtVL9rafYRAU8RmD4fcHYp/WEGvKFj3muKXRHjNQ5PN5Cs5PuqXGGqU/nQq5cqM5slV99jFp22nMI56iH6KK6sWjMDyKXrN6uZjsL3VsGeScIZHf7nBwXQZHFA3cf9Ejr9f6WrJknGCuMunG4uXP3FYZEiizl+1177tLX7fJLTkJfZ3wLcVzGiiYY7u2yuhy89CzTwrZSklzuMjiNlKaF6++bah+F20VaDROp2vN1K5FWUUzijtz54mZK5bVB3ooc5aEmy0WSVf2wIlmK8ac=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K2lyZ1VpRFVlYkx1STRGVjRkOGp0WUxYaVI0aDlkUG9YNmM2blhNU0lIMGJU?=
 =?utf-8?B?UXU4cGxaUXIzVDlTUExtYVl5ZkRXYUdLVlliVU9yT1Q3ZXprME4zeVRtbE9q?=
 =?utf-8?B?VGk5bmQ2cnFpS1hieElxRjg1SGhVMVI3Zm4zZjFjMDdBR3RYUkVaN2RRZEMv?=
 =?utf-8?B?WmdFd2RTaVBER2w4RFNkZGxTRk9kS0l3K3l5RWRqNHVCTVJ6c1NrU1ZWeGFF?=
 =?utf-8?B?VG9ad2V4SmM4SEk1RHJGMWdOVy9zNUZJOURkTmZ5cHRUOVhFTkxzRDdvc3Z0?=
 =?utf-8?B?YnpNVVVSeHg2dkdjWExCeHp3OHgvUitqYTZYb1dhaVhrbkhqUnFaaUVDb0ZO?=
 =?utf-8?B?NEVSdTVremxzT2NzTlNCUjhsSk40bEVQY2ZrYnM5MVV6bDZqVHAzSTY5WjNI?=
 =?utf-8?B?cm92Q293bUZIRHZVSytjTlNHWDhOM0VPaXNBZ2Eybjk3VG5qWDZLM3dQQWJO?=
 =?utf-8?B?ZnJ5c0JGMXR6Smx0NVExY1BUSEdKVVVFYXdURTZmU2FxY252YzNzWDB4N0VJ?=
 =?utf-8?B?cFlVZmdoZHVBSGZFZmF3WHZ5U3p6Nll5WUZLekNMaHNWOUJHbmloS1ZrZGVV?=
 =?utf-8?B?MjR2eStWVlAxOFlvMWc3WVRhR1NBTTEyK3gza0lERldUTFpaREFDTnc0WkFG?=
 =?utf-8?B?aWtWL0l6emxycHV1dWlvemtEdUVQbm5nMCtxYXVndndnWm9Ob2VVVHVCaURp?=
 =?utf-8?B?Y2trWjNWQW5vaU4vcXVuVm1CaGVsRGpJVXpxMzc4M0VRaWtLUDVFc3RxQnVJ?=
 =?utf-8?B?MjNrc21HaFdPa2lkdGFzWkhkTko2eG5XKzZhclkxSTJNOTRPbVRRWUNWSHVy?=
 =?utf-8?B?LzJOL1VMdUI3a1Z0cjdNZHB2U24xQlFmZC9JZmtoMVdLU05HS2hzUEtFUUdY?=
 =?utf-8?B?emwzMW9FclhPZnphMXlLWTJiaGZhdDhHNUVRNnRVdjNYYTF4Vkc3WTV3TCs2?=
 =?utf-8?B?T2U4ck9hUzRWeG5IUnFZRUdvcXhWajVDSCtTRDQwVlU3aG9CdU8rek5jSEwx?=
 =?utf-8?B?SDdEWWJ1T1M3dDZXa3U1a1l4eVp3a2RVMGZHUDROb2NSL1NqSC9TRnI0UmZx?=
 =?utf-8?B?ajVRYytDYWR5dmdiRytrOElnWGQ0cnZqYWFxaVFxN2tjMUVxZzlxSjVnbGUv?=
 =?utf-8?B?UlNaSkErL0lvNm9Eb1FaVTlxTG9PMndFdXZhVEFJcDRxY05obnoyRisvMlNH?=
 =?utf-8?B?ZXBpU2J5VmEyNFFHamR3VVRGZVAwOGFIeEpjMVJMK1owWTJQWXVVVXQvTmVG?=
 =?utf-8?B?cHRUcFBRcHFWNWF1ZUx3YWVTYUZnak52RzhWYklxeHVZR1ZLMjVUeXhSWmpt?=
 =?utf-8?B?LzdUYnpzbDZNVVpLK00xT1gyNkt5RHRjVERrMmtYVEFveXBOUGR5M3R2YUpV?=
 =?utf-8?B?SUZKZ1A1QWFia25aVitWRzZCaEZkWVN6RWNqUDNSWGV3Yks1VVNUQTVQNGlM?=
 =?utf-8?B?cng3ZkNaT3JWdTBIbitCWkxSS0hjemlqNXpUQ2FEQ2VVeTIvd0w2UFVTZ0xY?=
 =?utf-8?B?SC9xVjJ3enhqN2VxZi9Wd05hL015SHZKRHBsb0w3bGZkaWdTb0tMVmtUemhD?=
 =?utf-8?B?RkNQcEZJbzlMeDlXRHIrODFFWXhJbGpmbFhnZ05VSGd5UU0xOGhXaVRSbWpL?=
 =?utf-8?B?aUowalZjbC90OUFZMGZ6YTRZQ25rTzZib0M2dm4wcExCTFFZekhKWEtzZTZz?=
 =?utf-8?B?VE1tU0txRnlXSHhmY2dtR0VzUFZBZk9VWjVwdG1jVTVPM2FZaVhScTllLzN3?=
 =?utf-8?B?ZEYzNkdWR1BhWnJtNGlZS012OXVLem8xRFJwRVFDQ2ZqdndiU3I5WnNLTHl2?=
 =?utf-8?B?SHVHeWZjZS9oUUJCcVFUZXVvZWlmYmxrOUwvOCtRaGJzdE9rdmNZd0JNSVBp?=
 =?utf-8?B?c1pGbk82UlFpOW5DNGVVQ0ZNMnozdzVaZlpwU2VrenoxZGJDSGdNQzZDZWd3?=
 =?utf-8?B?Uy81V3BVc2hOS1pESlRQQk9oOVloWm94RmJEbEdMejBwYUpHNWxpbGtMTld3?=
 =?utf-8?B?dmZnY2pSVjVFWm92QTFRaWJOSWJGM2JLT0hUczhiNVNQWS9qTFpzWE5sVG5O?=
 =?utf-8?B?TTFJY1RoR1NFU0VsWmVLR0hOblEwc1FwYmwyOE40cGRWRS8zWDdwdmxJTHVZ?=
 =?utf-8?B?WUxQbVByNkdnVFVXOUtSbTNFSUlwNk5hZzZpR3pEWDgxS2w3MkFmdVJUZmFj?=
 =?utf-8?B?WXZIeUVYTnRGUWg3K09raEpYbTlkT1lkVDg3NjRaVHNuY25TWkZXTVRJaDdM?=
 =?utf-8?B?aEhKWHU1bktRQVJrVE1lL1RhNVpCY1BlUFNWQVNZS2s2YWlnSWNkUGtac21U?=
 =?utf-8?Q?9vFX1iu4vnrsUauEeq?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d17538fc-cc77-45d7-5e2b-08de86659398
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2026 09:46:36.2729 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FkbsC16WLVgQqM6/43oZxgHayu7yZ9LsYB4v6ycJPr2a+2qwRHfo4KSLDSxe0ldL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF89A593F05
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

On 3/20/26 10:41, Sunil Khatri wrote:
> There is a possibility of deadlock when last reference to a queue is
> put in certain situations where mutex is already help when calling
> the amdgpu_userq_destroy.

As far as I can see that is illegal to begin with. Why are we doing that?

Regards,
Christian.

> So based on the thread where it could be
> locked we pass the locked information in the destroy functionality
> to avoid taking the lock again.
> 
> Cc: Liang, Prike <Prike.Liang@amd.com>
> Suggested-by: Liang, Prike <Prike.Liang@amd.com>
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c     | 52 +++++++++++++------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h     |  2 +-
>  .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   |  4 +-
>  3 files changed, 40 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> index ced9ade44be4..9482664e9c2c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -617,13 +617,17 @@ amdgpu_userq_get_doorbell_index(struct amdgpu_userq_mgr *uq_mgr,
>  }
>  
>  static int
> -amdgpu_userq_destroy(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermode_queue *queue)
> +amdgpu_userq_destroy(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermode_queue *queue,
> +		     bool locked)
>  {
>  	struct amdgpu_device *adev = uq_mgr->adev;
>  	int r = 0;
>  
> -	cancel_delayed_work_sync(&uq_mgr->resume_work);
> +	/* It safe to unlock since we are in destroy and the queue ref is only this */
> +	if (locked)
> +		mutex_unlock(&uq_mgr->userq_mutex);
>  
> +	cancel_delayed_work_sync(&uq_mgr->resume_work);
>  	/* Cancel any pending hang detection work and cleanup */
>  	cancel_delayed_work_sync(&queue->hang_detect_work);
>  
> @@ -657,13 +661,27 @@ amdgpu_userq_destroy(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermode_que
>  		queue->state = AMDGPU_USERQ_STATE_HUNG;
>  	}
>  	amdgpu_userq_cleanup(queue);
> -	mutex_unlock(&uq_mgr->userq_mutex);
> +
> +	if (!locked)
> +		mutex_unlock(&uq_mgr->userq_mutex);
>  
>  	pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
>  
>  	return r;
>  }
>  
> +static void amdgpu_userq_kref_destroy_locked(struct kref *kref)
> +{
> +	int r;
> +	struct amdgpu_usermode_queue *queue =
> +		container_of(kref, struct amdgpu_usermode_queue, refcount);
> +	struct amdgpu_userq_mgr *uq_mgr = queue->userq_mgr;
> +
> +	r = amdgpu_userq_destroy(uq_mgr, queue, true);
> +	if (r)
> +		drm_file_err(uq_mgr->file, "Failed to destroy usermode queue %d\n", r);
> +}
> +
>  static void amdgpu_userq_kref_destroy(struct kref *kref)
>  {
>  	int r;
> @@ -671,7 +689,7 @@ static void amdgpu_userq_kref_destroy(struct kref *kref)
>  		container_of(kref, struct amdgpu_usermode_queue, refcount);
>  	struct amdgpu_userq_mgr *uq_mgr = queue->userq_mgr;
>  
> -	r = amdgpu_userq_destroy(uq_mgr, queue);
> +	r = amdgpu_userq_destroy(uq_mgr, queue, false);
>  	if (r)
>  		drm_file_err(uq_mgr->file, "Failed to destroy usermode queue %d\n", r);
>  }
> @@ -689,10 +707,14 @@ struct amdgpu_usermode_queue *amdgpu_userq_get(struct amdgpu_userq_mgr *uq_mgr,
>  	return queue;
>  }
>  
> -void amdgpu_userq_put(struct amdgpu_usermode_queue *queue)
> +void amdgpu_userq_put(struct amdgpu_usermode_queue *queue, bool locked)
>  {
> -	if (queue)
> -		kref_put(&queue->refcount, amdgpu_userq_kref_destroy);
> +	if (queue) {
> +		if (locked)
> +			kref_put(&queue->refcount, amdgpu_userq_kref_destroy_locked);
> +		else
> +			kref_put(&queue->refcount, amdgpu_userq_kref_destroy);
> +	}
>  }
>  
>  static int amdgpu_userq_priority_permit(struct drm_file *filp,
> @@ -978,7 +1000,7 @@ int amdgpu_userq_ioctl(struct drm_device *dev, void *data,
>  		if (!queue)
>  			return -ENOENT;
>  
> -		amdgpu_userq_put(queue);
> +		amdgpu_userq_put(queue, false);
>  		break;
>  	}
>  
> @@ -1007,7 +1029,7 @@ amdgpu_userq_restore_all(struct amdgpu_userq_mgr *uq_mgr)
>  			drm_file_err(uq_mgr->file,
>  				     "trying restore queue without va mapping\n");
>  			queue->state = AMDGPU_USERQ_STATE_INVALID_VA;
> -			amdgpu_userq_put(queue);
> +			amdgpu_userq_put(queue, true);
>  			continue;
>  		}
>  
> @@ -1015,7 +1037,7 @@ amdgpu_userq_restore_all(struct amdgpu_userq_mgr *uq_mgr)
>  		if (r)
>  			ret = r;
>  
> -		amdgpu_userq_put(queue);
> +		amdgpu_userq_put(queue, true);
>  	}
>  
>  	if (ret)
> @@ -1258,7 +1280,7 @@ amdgpu_userq_evict_all(struct amdgpu_userq_mgr *uq_mgr)
>  		r = amdgpu_userq_preempt_helper(queue);
>  		if (r)
>  			ret = r;
> -		amdgpu_userq_put(queue);
> +		amdgpu_userq_put(queue, true);
>  	}
>  
>  	if (ret)
> @@ -1298,17 +1320,17 @@ amdgpu_userq_wait_for_signal(struct amdgpu_userq_mgr *uq_mgr)
>  		struct dma_fence *f = queue->last_fence;
>  
>  		if (!f || dma_fence_is_signaled(f)) {
> -			amdgpu_userq_put(queue);
> +			amdgpu_userq_put(queue, true);
>  			continue;
>  		}
>  		ret = dma_fence_wait_timeout(f, true, msecs_to_jiffies(100));
>  		if (ret <= 0) {
>  			drm_file_err(uq_mgr->file, "Timed out waiting for fence=%llu:%llu\n",
>  				     f->context, f->seqno);
> -			amdgpu_userq_put(queue);
> +			amdgpu_userq_put(queue, true);
>  			return -ETIMEDOUT;
>  		}
> -		amdgpu_userq_put(queue);
> +		amdgpu_userq_put(queue, true);
>  	}
>  
>  	return 0;
> @@ -1366,7 +1388,7 @@ void amdgpu_userq_mgr_fini(struct amdgpu_userq_mgr *userq_mgr)
>  		if (!queue)
>  			break;
>  
> -		amdgpu_userq_put(queue);
> +		amdgpu_userq_put(queue, false);
>  	}
>  
>  	xa_destroy(&userq_mgr->userq_xa);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> index f0abc16d02cc..2a496e74ec6a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> @@ -116,7 +116,7 @@ struct amdgpu_db_info {
>  };
>  
>  struct amdgpu_usermode_queue *amdgpu_userq_get(struct amdgpu_userq_mgr *uq_mgr, u32 qid);
> -void amdgpu_userq_put(struct amdgpu_usermode_queue *queue);
> +void amdgpu_userq_put(struct amdgpu_usermode_queue *queue, bool locked);
>  
>  int amdgpu_userq_ioctl(struct drm_device *dev, void *data, struct drm_file *filp);
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> index 18390d37a7e0..10e08cb6bd13 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> @@ -612,7 +612,7 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
>  	kfree(syncobj_handles);
>  
>  	if (queue)
> -		amdgpu_userq_put(queue);
> +		amdgpu_userq_put(queue, false);
>  
>  	return r;
>  }
> @@ -914,7 +914,7 @@ amdgpu_userq_wait_return_fence_info(struct drm_file *filp,
>  		r = 0;
>  
>  put_waitq:
> -	amdgpu_userq_put(waitq);
> +	amdgpu_userq_put(waitq, false);
>  
>  free_fences:
>  	while (num_fences--)

