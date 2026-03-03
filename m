Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34A8EEC1444
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Mar 2026 13:47:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D1E7510E048;
	Tue,  3 Mar 2026 13:47:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xrkZhaRY";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011018.outbound.protection.outlook.com [52.101.52.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 75DA910E048
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Mar 2026 13:47:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TnplO7dmdztCVwSi/wa4HCphGy6XZA75cH6sesaQJb22GkcSkgRKjo3RZjH6gWSz6XG+H+OJMXma+VGWiII5Zym03slCtviaYrhb9Pql6jBzIdIebJPkVPWidNC2V7R811C85I1PSP3oFA/YjmNvfnDZ2HhgidW5RovBpoeapWZ+QJeiWh6q3/xtYXr5FnyamUI0HHA9MlTayIA7gMrhjBKylcctAkbVJ3Wrl9q8Acsqk5crCLI7abKIJKtdS1ZV0JSssgxaLU7tCiDInxO64kGQaY45O8gVPhRP9X+grrFOZDMn+g/rhIFH/2B5kW0qAS4MipJB7zK0ruvblvs9lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b64N05dOBBtJAunVKyoQv2Djo5SotcfQdgYVB90HtVY=;
 b=xMhm734k98zczAxiqVP3IpamlDDAOY+Zio2M+TWKqw14RhlZJ4Dy+1dJEkCrJCKd0KtWbrQ9DpwW/5zgOTjhT7QRm29LeSTu11eBT1nf7kDakWDKKO+q9ZdCzCYAWsMiUgYZaekIQn0/19VjRa7FoirnD/KxRyH/KMHavvFNVJPulBTrCqOZTWR0HG6CXe0hET5C3p+YmjkxnGm6VduusagZhGtOcbuXX4cfT+/4u4Ur3hz0JcemOKVcbXY7TmsOMYQcvCjE2hNmyRuZ1fQVNH98W7Ry9H4/+efZEKnexCt+nvj1JIoQkfznET2l4YMTRTZlsEtFkXG74TK2VJs3ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b64N05dOBBtJAunVKyoQv2Djo5SotcfQdgYVB90HtVY=;
 b=xrkZhaRYRp4cJHM2W2fmtNo+iSBLyRrWmjCW0CEKBWraWb/AEHudq+ktG90szU5iMCnlTz9qsqC19wk7NcxS6XU/REqFt6EwTpu4N89ENW9CZXK4SeFqU2U053dcAp0xexoYIwfOFSO/j2kmnjBA19mFGG5uPlhuJshqqsjIOZc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by BN7PPF28614436A.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::6c9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Tue, 3 Mar
 2026 13:47:01 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9654.022; Tue, 3 Mar 2026
 13:47:01 +0000
Message-ID: <38ec1a98-d112-4345-9711-d023a3e10da9@amd.com>
Date: Tue, 3 Mar 2026 14:46:57 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] drm/amdgpu/userq: refcount userqueues to avoid any
 race conditions
To: Sunil Khatri <sunil.khatri@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260303120654.2582995-1-sunil.khatri@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260303120654.2582995-1-sunil.khatri@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN9P221CA0027.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:408:10a::21) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|BN7PPF28614436A:EE_
X-MS-Office365-Filtering-Correlation-Id: 2aa3db02-d144-4df3-392a-08de792b5890
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: jv2Q2cE1omsTc+wGaOgjNLX+IZv8U8IIQt0Jox61qTY7fv7C2sArYYXLg7QH3Ubhf+vHWAwpptoi/RoRwKMSzmQ7l/RN5fxChNm0GZbyp/SQDhk8lyzhjrr3R//3ghMJdf9aCvTWfYMg1a2JxT4nCgkwqHoGVv6luaf06STjsyEi5/V1uqB3Er3eqKmSfftz9FHlECvLoB/9NIlA+WVC3ixYj+0cyI9B0t4vrGjZsuQ+Go/O96pLk3NAtfBO3u7QYphq3dnWLThQ5+ryOxPuXY2pp/iMtvGYVvvU/fmyG2kmOBv4kbyxj6n2UOSaxG9vFgeoxZk4CP9Pn+tEHY3DycgXwWoL3KPKgf3dnR3/5afzaYinj1+++pvsQxdBtBHVjDPrzJLkGcBTrzg7swQHzQefZUdCewbqMjBDFIOBcKMcsNn9QjXB8dTx+Lj5JvFyvptrvCLD9/XI6zq4F8L1FL86Mkt9YH4Th2WJpxv/zd7Qi+jtRUsKo3lBfGlk9d58QDhn0G1a+3tK68MPqmFu2OGePUrxAFcyfzK8yACxV4vuckKiiKJ8hMyKQNqjkMD4TRP3fnVq7pEksm524NEvcBiHorqe40H4H8osBCkFTRPa5klSmbBXYzhGlG7sTesZ1CQqOfBoOwdLORinK6VpUHgsfAHvtEUtWjRUnUREOUApotIaUM/cij81J9MoEzd6eulkIwbP59nThFvRAqJO8hrYVp//FOtmdmWkUH/bVwI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T25iODdpdlk1Z0RvWGZYSkdVenFqNkl4Q1R1YmluZXE5QlpOb3gvK3V1aGN0?=
 =?utf-8?B?TjNBUkFUMmljbDJCdktHNFFRS1dLMHVMUmdleTByMDdsaFZNMGpKMmprVGNC?=
 =?utf-8?B?RTkxZ0VjNGdUZ2krSGNtVmpKVm5mNmJnb25EU3o4YUZxSk42dTRXK1VvckR4?=
 =?utf-8?B?WVY4WWZJbW1EWUxsRm1HbHhSZGx6ekNVRDFpd0x3Mk1ZcUxMSDFzd3MwdDVQ?=
 =?utf-8?B?Q2R3bHBtZzdWZXo2d0FSdnQzZmEyeHA3K3Z6a29iTGU4RkNCRmliNHJHdnhs?=
 =?utf-8?B?ajYwRG8wN21kWDlIK2toR2NsN09HQ2JKd0swSkxXYnkzYmZQaHg0a1gzYmZU?=
 =?utf-8?B?dEdDd2FvUVd1ZkRmSzc5NDR5dUFZaHoyWWtsbithVTZRSjZWaW9OT2JFVmZx?=
 =?utf-8?B?LzF1TWVNNm4vU2dQWTQ5TEhYSHlldWxibWFzVGNiODM3V1g0dzVadkFhVlRu?=
 =?utf-8?B?T1pabGxpcDRPRzRLUWFJaGZYRk9KRE1uczRNVUJ6azlVOTd2WjNLUGpScTNQ?=
 =?utf-8?B?L0JYU3VGVDhPN0xQdHppaTdNWkdFNTMwZFRQNFZrSHJ0YmNWaEw5eWwwQ3R5?=
 =?utf-8?B?amhacE81MkhZZjI3dGlhVjc0dFE1bDZjWUhvakxzbGIxa2JEKzNEa21LT1Ar?=
 =?utf-8?B?blNJamkwWDZxM2pMVFdmZko2YldNbmpoMFVwR21lT0FiVG9laXBCYnJmSSt4?=
 =?utf-8?B?NjZmSzh4djlhS3ZtRXRJbkx2Wm5lUHdUaVkrY3ZuNjU4Qk9HMlhzK3lZODZN?=
 =?utf-8?B?bE4wNjIyM0NSaW5PVEIvRDhYaWN2eWZEcDFUaWUyRlNiREJWb2VzQ2JkUURH?=
 =?utf-8?B?MEltWHdBR2JzVkFPT3gxNmZPZStwd3BLQWNDZ0pvVVdlaklTYTFJNlFpQi93?=
 =?utf-8?B?bWIvMCtKZ2ZsNUVCVFpaRW5YbjQvZGoxUU9ZY0pzQXhTalI2U0lRSHhtVFFv?=
 =?utf-8?B?QzIweURFbmo2YzFKNTUvUE9hK29IRnF1Tms4SlZBWTl4bEp2QStuTVp4V2VV?=
 =?utf-8?B?MVRLK0M3WnpZTlZpR3NhZGtwZmlDYXNQbE1maEp0aE8xc1I0UEI1ZUZWdFBj?=
 =?utf-8?B?QnZUS0VTR3V5VmxtamxIcmsyQjZCdHMwRDJLWFlHREZQNzFWcVBkTStsNkNl?=
 =?utf-8?B?MmpPUGx1YkxNT09RL05pUUI1TnM1UmtQcjdYVlRTUlNIak1ZQnJmajh2bnRG?=
 =?utf-8?B?UTJzaS8wcXRnaUhWOHgyOENMNGV3UjNCakRtN1l6MTNROVRlU3ZvVUlCS0h6?=
 =?utf-8?B?WFY0OEF2eHBtWXI2KzZocW9lZDlKUE04ako3NExXVWxwUG5lWjBnY3NYZE9m?=
 =?utf-8?B?RlR5MDdLeTdSa2ZrOHA0MnFmYnFXNU1nSFRHa3Rrd3AwTGZOQTZxWUlEY3ly?=
 =?utf-8?B?cGhpeE9mQ0ZlakJxZWtwbHRVdzVjU3dqRjJTUTNBTlFGUy9sRkdJZGR5U3Bo?=
 =?utf-8?B?QU10T0RsanlpeVptNlpTQWFPaGtacjkvTE1PVDQ0NkhkczRSQ2ovODJNdGQr?=
 =?utf-8?B?RmFMM1Q3cllwdGdRZWF1ay9BY1hYdDFXbFZYQVhsYVpiV29ybmlpaFNod0J0?=
 =?utf-8?B?dEFFQWoxR0E5M3dldlJSWWNON0s2N2lDNTYzWVZ4NlREUlJqc3Q3YWEzL1pJ?=
 =?utf-8?B?cG8xTCt1ZjV5OEY5U2tPMVdFTGI4d3FweEdDREI4dFVXSmptbk4zUGxPUG9r?=
 =?utf-8?B?WVlnRDUxVzJQdy9pdU1vdVVlTDB0eTU2VVFtL1JjMU5pL2pUZG1nb3J1Zksv?=
 =?utf-8?B?YmNVRFVFVDFmeUYwMXE1UzRIYTNoTDI4SDNmbFRpaGJLT1RtR0VOVHFUVVdE?=
 =?utf-8?B?L1FPMFdrK1R2SGxUNTVEYWJFZzlFSVpTY2ZFT1dSU1dBQmlkeGJFTFM3OS8z?=
 =?utf-8?B?N21YYUVKUDVOZ1hjUmRkdmI5elpiVERSdlR2ektWWFNQUzJGS1NEVGRLaFBu?=
 =?utf-8?B?VkQvcTJIMlF5bkRkZnRXZWRSQTNWZ1ZFZGdCbTRjSG1JdzBINDFrMFBpekk5?=
 =?utf-8?B?SWp3UEkwUk1pdGxucUR2VHY5NVlLZmJmYnlES1lzNXQ2amtORi9FZTdxSElu?=
 =?utf-8?B?QWltbGhEdjNCWWl4UWZHMkEvSm82MndDbkZldFJJSGl5L29rT3RUUmY2aGZy?=
 =?utf-8?B?K3BPTGNWMTVxdzJqeEpyampaY1dRSGR4VmMvSkFzbWRtVEhFaUY2RlIvMGRV?=
 =?utf-8?B?RzRtVDVTQTl4a29jemlBdXpVd0Zxdzc3cjErNmN6YngxeTZhWlE1ZjFhNGx3?=
 =?utf-8?B?ZTlZVUZnOEFOb3BhaWxXYS9Kd3hjMFQrNVI4S0xCWlNFYis0UVkxQmJDL01Z?=
 =?utf-8?Q?lmKcH41zbxRbovZnu7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2aa3db02-d144-4df3-392a-08de792b5890
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2026 13:47:01.1790 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sxt8Mxgu2xo12IY4VVF7pBMYzTk/lBeknmhgNdDelWDIBRLrYezMka6P/Bq3bxcB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF28614436A
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

On 3/3/26 13:06, Sunil Khatri wrote:
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
> v2: Add the missing drop in one the condition in the signal ioclt [Alex]
> 
> v3: remove the queue from the xarray first in the free queue ioctl path
>     [Christian]
> 
> - Pass queue to the amdgpu_userq_put directly.
> - make amdgpu_userq_put xa_lock free since we are doing put for each get
>   only and final put is done via destroy and we remove the queue from xa
>   with lock.
> - use userq_put in fini too so cleanup is done fully.
> 
> v4: Use xa_erase directly rather than doing load and erase in free
>     ioctl. Also remove some of the error logs which could be exploited
>     by the user to flood the logs [Christian]
> 
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c     | 110 ++++++++++++------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h     |   4 +
>  .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   |  14 ++-
>  3 files changed, 91 insertions(+), 37 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> index e07b2082cf25..ed6a9d779d1b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -446,8 +446,7 @@ static int amdgpu_userq_wait_for_last_fence(struct amdgpu_usermode_queue *queue)
>  	return ret;
>  }
>  
> -static void amdgpu_userq_cleanup(struct amdgpu_usermode_queue *queue,
> -				 u32 queue_id)
> +static void amdgpu_userq_cleanup(struct amdgpu_usermode_queue *queue)
>  {
>  	struct amdgpu_userq_mgr *uq_mgr = queue->userq_mgr;
>  	struct amdgpu_device *adev = uq_mgr->adev;
> @@ -461,7 +460,6 @@ static void amdgpu_userq_cleanup(struct amdgpu_usermode_queue *queue,
>  	uq_funcs->mqd_destroy(queue);
>  	amdgpu_userq_fence_driver_free(queue);
>  	/* Use interrupt-safe locking since IRQ handlers may access these XArrays */
> -	xa_erase_irq(&uq_mgr->userq_xa, queue_id);
>  	xa_erase_irq(&adev->userq_doorbell_xa, queue->doorbell_index);
>  	queue->userq_mgr = NULL;
>  	list_del(&queue->userq_va_list);
> @@ -470,12 +468,6 @@ static void amdgpu_userq_cleanup(struct amdgpu_usermode_queue *queue,
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
> @@ -625,22 +617,13 @@ amdgpu_userq_get_doorbell_index(struct amdgpu_userq_mgr *uq_mgr,
>  }
>  
>  static int
> -amdgpu_userq_destroy(struct drm_file *filp, u32 queue_id)
> +amdgpu_userq_destroy(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermode_queue *queue)
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
> @@ -672,13 +655,44 @@ amdgpu_userq_destroy(struct drm_file *filp, u32 queue_id)
>  		drm_warn(adev_to_drm(uq_mgr->adev), "trying to destroy a HW mapping userq\n");
>  		queue->state = AMDGPU_USERQ_STATE_HUNG;
>  	}
> -	amdgpu_userq_cleanup(queue, queue_id);
> +	amdgpu_userq_cleanup(queue);
>  	mutex_unlock(&uq_mgr->userq_mutex);
>  
>  	pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
>  
>  	return r;
>  }
> +static void amdgpu_userq_kref_destroy(struct kref *kref)
> +{
> +	int r;
> +	struct amdgpu_usermode_queue *queue =
> +		container_of(kref, struct amdgpu_usermode_queue, refcount);
> +
> +	struct amdgpu_userq_mgr *uq_mgr = queue->userq_mgr;
> +
> +	r = amdgpu_userq_destroy(uq_mgr, queue);
> +	if (r)
> +		drm_file_err(uq_mgr->file, "Failed to destroy usermode queue\n");
> +}
> +
> +struct amdgpu_usermode_queue *amdgpu_userq_get(struct amdgpu_userq_mgr *uq_mgr, u32 qid)
> +{
> +	struct amdgpu_usermode_queue *queue;
> +
> +	xa_lock(&uq_mgr->userq_xa);
> +	queue = xa_load(&uq_mgr->userq_xa, qid);
> +	if (queue)
> +		kref_get(&queue->refcount);
> +	xa_unlock(&uq_mgr->userq_xa);
> +
> +	return queue;
> +}
> +
> +void amdgpu_userq_put(struct amdgpu_usermode_queue *queue)
> +{
> +	if (queue)
> +		kref_put(&queue->refcount, amdgpu_userq_kref_destroy);
> +}
>  
>  static int amdgpu_userq_priority_permit(struct drm_file *filp,
>  					int priority)
> @@ -891,6 +905,8 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>  
>  	args->out.queue_id = qid;
>  	atomic_inc(&uq_mgr->userq_count[queue->queue_type]);
> +	/* drop this refcount during queue destroy */
> +	kref_init(&queue->refcount);
>  
>  unlock:
>  	mutex_unlock(&uq_mgr->userq_mutex);
> @@ -985,6 +1001,8 @@ int amdgpu_userq_ioctl(struct drm_device *dev, void *data,
>  		       struct drm_file *filp)
>  {
>  	union drm_amdgpu_userq *args = data;
> +	struct amdgpu_fpriv *fpriv = filp->driver_priv;
> +	struct amdgpu_usermode_queue *queue;
>  	int r;
>  
>  	if (!amdgpu_userq_enabled(dev))
> @@ -1000,11 +1018,14 @@ int amdgpu_userq_ioctl(struct drm_device *dev, void *data,
>  			drm_file_err(filp, "Failed to create usermode queue\n");
>  		break;
>  
> -	case AMDGPU_USERQ_OP_FREE:
> -		r = amdgpu_userq_destroy(filp, args->in.queue_id);
> -		if (r)
> -			drm_file_err(filp, "Failed to destroy usermode queue\n");
> +	case AMDGPU_USERQ_OP_FREE: {
> +		queue = xa_erase(&fpriv->userq_mgr.userq_xa, args->in.queue_id);

You need to have xa_lock around that or otherwise xa_load/kref_get can race.

Apart of that Reviewed-by: Christian König <christian.koenig@amd.com>

Regards,
Christian.

> +		if (!queue)
> +			return -ENOENT;
> +
> +		amdgpu_userq_put(queue);
>  		break;
> +	}
>  
>  	default:
>  		drm_dbg_driver(dev, "Invalid user queue op specified: %d\n", args->in.op);
> @@ -1023,16 +1044,23 @@ amdgpu_userq_restore_all(struct amdgpu_userq_mgr *uq_mgr)
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
> +			amdgpu_userq_put(queue);
>  			continue;
>  		}
>  
>  		r = amdgpu_userq_restore_helper(queue);
>  		if (r)
>  			ret = r;
> +
> +		amdgpu_userq_put(queue);
>  	}
>  
>  	if (ret)
> @@ -1266,9 +1294,13 @@ amdgpu_userq_evict_all(struct amdgpu_userq_mgr *uq_mgr)
>  	amdgpu_userq_detect_and_reset_queues(uq_mgr);
>  	/* Try to unmap all the queues in this process ctx */
>  	xa_for_each(&uq_mgr->userq_xa, queue_id, queue) {
> +		queue = amdgpu_userq_get(uq_mgr, queue_id);
> +		if (!queue)
> +			continue;
>  		r = amdgpu_userq_preempt_helper(queue);
>  		if (r)
>  			ret = r;
> +		amdgpu_userq_put(queue);
>  	}
>  
>  	if (ret)
> @@ -1301,16 +1333,24 @@ amdgpu_userq_wait_for_signal(struct amdgpu_userq_mgr *uq_mgr)
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
> +			amdgpu_userq_put(queue);
>  			continue;
> +		}
>  		ret = dma_fence_wait_timeout(f, true, msecs_to_jiffies(100));
>  		if (ret <= 0) {
>  			drm_file_err(uq_mgr->file, "Timed out waiting for fence=%llu:%llu\n",
>  				     f->context, f->seqno);
> +			amdgpu_userq_put(queue);
>  			return -ETIMEDOUT;
>  		}
> +		amdgpu_userq_put(queue);
>  	}
>  
>  	return 0;
> @@ -1361,20 +1401,24 @@ int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, struct drm_file *f
>  void amdgpu_userq_mgr_fini(struct amdgpu_userq_mgr *userq_mgr)
>  {
>  	struct amdgpu_usermode_queue *queue;
> -	unsigned long queue_id;
> +	unsigned long queue_id = 0;
>  
>  	cancel_delayed_work_sync(&userq_mgr->resume_work);
> +	for (;;) {
> +		xa_lock(&userq_mgr->userq_xa);
> +		queue = xa_find(&userq_mgr->userq_xa, &queue_id, ULONG_MAX,
> +				XA_PRESENT);
> +		if (queue)
> +			__xa_erase(&userq_mgr->userq_xa, queue_id);
> +		xa_unlock(&userq_mgr->userq_xa);
> +
> +		if (!queue)
> +			break;
>  
> -	mutex_lock(&userq_mgr->userq_mutex);
> -	amdgpu_userq_detect_and_reset_queues(userq_mgr);
> -	xa_for_each(&userq_mgr->userq_xa, queue_id, queue) {
> -		amdgpu_userq_wait_for_last_fence(queue);
> -		amdgpu_userq_unmap_helper(queue);
> -		amdgpu_userq_cleanup(queue, queue_id);
> +		amdgpu_userq_put(queue);
>  	}
>  
>  	xa_destroy(&userq_mgr->userq_xa);
> -	mutex_unlock(&userq_mgr->userq_mutex);
>  	mutex_destroy(&userq_mgr->userq_mutex);
>  }
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> index f4d1d46ae15e..54e1997b3cc0 100644
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
> +void amdgpu_userq_put(struct amdgpu_usermode_queue *queue);
> +
>  int amdgpu_userq_ioctl(struct drm_device *dev, void *data, struct drm_file *filp);
>  
>  int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, struct drm_file *file_priv,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> index 3c30512a6266..a7ded25346b8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> @@ -470,7 +470,7 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
>  	struct drm_gem_object **gobj_write, **gobj_read;
>  	u32 *syncobj_handles, num_syncobj_handles;
>  	struct amdgpu_userq_fence *userq_fence;
> -	struct amdgpu_usermode_queue *queue;
> +	struct amdgpu_usermode_queue *queue = NULL;
>  	struct drm_syncobj **syncobj = NULL;
>  	struct dma_fence *fence;
>  	struct drm_exec exec;
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
> +		amdgpu_userq_put(queue);
> +
>  	return r;
>  }
>  
> @@ -626,7 +629,7 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
>  	struct amdgpu_userq_mgr *userq_mgr = &fpriv->userq_mgr;
>  	struct drm_gem_object **gobj_write, **gobj_read;
>  	u32 *timeline_points, *timeline_handles;
> -	struct amdgpu_usermode_queue *waitq;
> +	struct amdgpu_usermode_queue *waitq = NULL;
>  	u32 *syncobj_handles, num_syncobj;
>  	struct dma_fence **fences = NULL;
>  	u16 num_points, num_fences = 0;
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
> +		amdgpu_userq_put(waitq);
> +
>  	return r;
>  }

