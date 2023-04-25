Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40C36C6FD18
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Apr 2023 12:38:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ACCF210E726;
	Tue, 25 Apr 2023 12:38:33 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2086.outbound.protection.outlook.com [40.107.100.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4AD2710E726
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Apr 2023 12:38:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WM35IpzH6kZnnxibjrZgJC65Kh6+YBkR7Vb/javFgLLty8bDVXfKgHllRjLUl+Q3qgHZ25QRC2PvIkmmJTBz857+ey1omctZF4cxkdF3Tz9FirlOfcg1B2x9BEWoJ/5l1xVaIgennEy08+Odz75pbJJf1vXUr5Fmr6eTXwJD5jy/NGclciBcC/pq8biq4aa45l/J6kfPxULtZZolXhWtT7Ep6jUCWhcLX8UJ3frcKfPH7QYOv6z2CdAJLhNL2fCUZ2t90GwtpAw6rvO/2sc1qz7Qp/CNV0Ae593W5uSUw5yUOoILaPYi9t3mXTpjdK2po4u+Zc7aXwFOjFxiy2Hodg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mPuGvKHOEXcOjRuL9KoxuN811vNpF4gbhVg6Nfkzb4o=;
 b=icXA/QAOBtMTfRHozPOtaBEx1NogjWjtBidyBukvIsqkXSHHkj42tmJ6S+bP9cKlHiQqtuuSX1s9B4vt587e0paHy0RAiruF0MofVPAFg6YTU4w/4kayHHrrx3M21PKR55X+PJxCCdUZKcN8NifpJup50G+211OrP08iTOxavMsB6zZRPPlot9S+cmIUhCu4wRv3mMrdaitJzLCH/IPCWJ7u/N4VDS9cy8j6SFARqWto1HUL3masqqGlSFnQCIb3QRttQDHgj5q7Ursdx8DxU6LuKmqomg4iByt+7uMSdSijU3peIIT6IXEYQGEkoUs66o21YotpVAQCfVxPaaookg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mPuGvKHOEXcOjRuL9KoxuN811vNpF4gbhVg6Nfkzb4o=;
 b=bMbRpp1GhUhL0HME4VuYFnQx/G/Obf0DCU0m5k2cgUHwIqZ+Y39nh+ZMGe6LCtGTcE0RoBFoOiB7sC//bYBIAbfDI5VsJ55lGQK5vyN9j2HX4061/HPMoYG1gSorZYziW4SLGmVrNXRWEX3IcUnjeQOx/p6JbuenGcu53S+1p9w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by SJ1PR12MB6049.namprd12.prod.outlook.com (2603:10b6:a03:48c::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33; Tue, 25 Apr
 2023 12:38:28 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::d2f8:7388:39c1:bbed]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::d2f8:7388:39c1:bbed%3]) with mapi id 15.20.6319.034; Tue, 25 Apr 2023
 12:38:28 +0000
Message-ID: <44d081c1-8bd3-53ba-a60b-0fd6fe630aa0@amd.com>
Date: Tue, 25 Apr 2023 14:38:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v4 09/10] drm/amdgpu: generate doorbell index for userqueue
Content-Language: en-US
To: Shashank Sharma <shashank.sharma@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230424173836.1441-1-shashank.sharma@amd.com>
 <20230424173836.1441-10-shashank.sharma@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20230424173836.1441-10-shashank.sharma@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0046.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:92::20) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|SJ1PR12MB6049:EE_
X-MS-Office365-Filtering-Correlation-Id: 607c8546-5e0d-4fbe-191c-08db4589f886
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: huC5qRZPjjPIbPu48lRz3LSO1/1TSZy84j0CpYslaOV1uGKST/jEXFv1kYj9qrq8nNXIUpFdIAp084Ha4Si2p+Wtw35yXQVewSYFRb5BHZSKqjlZ9U6Uq5zRHVRBAHVLDYEP8peb7eTt8FC1Prev4GcShzOB+Juqvzlo4+SPBkryPZJ/SvFnwZmIj7HDuu9ulgg5ErtacgEYbT7QcEdGoqZS4ILIQbzybqr0DXyVaKclLTnrI9YD9hEvw7nQn2ysFmFTchVRYIQVD1cpNzvk0Hp2Koqb/Dq9BgniiKLCWqRw8mSnO/w0pmXbLyiEd6b2XUKFbKba98VHLssDFk7LbukM+re9g9VgKvJiIdbWfEC0gfbVAXLos2lSl725DmUxpkMKJFeScU2rszVNAHFkbrXJ24W+tZ3ihyIGpo5CBztMAkXwnrnyyaNkgwxTL7miGTHI8dXXuornBUJzUz85b05Rw86yD+fA7b8XVK1fCxU4UlGccLAlC0WIaIZdrpFI//Q4ofixk1GHD5LDcDQr6Gd/1vCaMayBJeI1g76iZlphI3Ljti7kNDMRULTBsi5Pm3vkLT2zGXpTV+Pg/KzfQD1iMQH7QyrC2RBTR8Wa65U=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(366004)(396003)(376002)(346002)(136003)(39860400002)(451199021)(41300700001)(5660300002)(8936002)(8676002)(186003)(6512007)(6506007)(2616005)(38100700002)(86362001)(31696002)(66476007)(4326008)(316002)(6486002)(36756003)(966005)(66946007)(66556008)(478600001)(6666004)(31686004)(2906002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NHJNQmJEbGxrbG51bExJMzFiMGl3S1BJbFpFY3FRY1VRb04zTUVpcXUyZnQv?=
 =?utf-8?B?OStWQWFaMnNkMy94ci8yTTl5UHl0ajR6bWhkU29nMklzVUZTalI3Z3oxTGZx?=
 =?utf-8?B?S2xrY0tVK0dBT2FFbEp2cHlLT2hjdUl3akF3K1VJbHdLYlBIbDBzRGNtNzhG?=
 =?utf-8?B?ZmltbXJyVTJBeXFBWVdmQ3MxWG9IdnBqWUo3VWVhNHdReGhGYmdxYkorN2tE?=
 =?utf-8?B?TEZCWGl2SUc5RitPNm02cW5iMWp4REFBL2hrSE12Z3F0bnJySE9pNE1uUnF0?=
 =?utf-8?B?M2ovMU82aWlGYWFKZ3d2eG9TNndRYnB0S2VFbThuN0dld3QyL2JDQzZvZ2Zv?=
 =?utf-8?B?RTJPaEdiRUh3blJDcFBGWlpZTG80UVZYK25yVFgwdjFLL2VOSVU2TUQzb3F5?=
 =?utf-8?B?dm9NVWkxOG5xTEIwbjZkRENnaDQ0dmkzeGk4S2RFeC9Wb0hXRGNMTmNORW1V?=
 =?utf-8?B?L2VIL2JzeFRFd2FhNFpsOXA0WEFKQ0s4U0NuWmZyWUJxQzgramY0N0JQS1B4?=
 =?utf-8?B?eUMvcTY2alhLeWRvM3ZaRzNBMFRoQTFnRzh3ODZUTG9tN1NPV2ZPa0tJcnF2?=
 =?utf-8?B?cTRabWNxU0hFeGF1SE5KYnNNK1IwbkJsMnFSazc3WUZEdElhNGNGY0h2d21q?=
 =?utf-8?B?LzdvZkdnS3RtMC9mMXZlKzVpUWpTNEJiL3dsajlmcFNHTXBMUEF6aWJjZzly?=
 =?utf-8?B?SHc0WU5HeHdYV0o0ZUt2TS9HRkovQlBlZnZGTG9IN0ZLZlRhbVVFemgwVUJs?=
 =?utf-8?B?TVZwME9QQ2RCR2UyUllCL1JMT3dhSVJNYTRlTDYwVVljOUtEd0R2aTVGUUFl?=
 =?utf-8?B?VTZmQThNbmVXNlFPWXVRbHNwdFhLMzV4RFJ1R3FrYmlkRGUyaXlxdW0wQ3U2?=
 =?utf-8?B?Z1M0aXo4NW9tWFlmcDdYOHU1ZlZIajhad0EvMUdseHJBZ3ZmQVFrdzBWanVx?=
 =?utf-8?B?NTlLN2I2UXcrR0dTdnB2eldFMkFxeU4rREJLdHozWlJGamY0dEZvMko1ZGRJ?=
 =?utf-8?B?MFcxSnFNY1hlaEVoU3l3ZmM1dnFBUEZ6S0VkQkFQc3JKSXAzMVZ3cG9ZOG13?=
 =?utf-8?B?OGtNczNxVCs3a2FPWVZvdFJZOGxiNU1GUXFoWjJPcVMwQnFoVGNDcGdScERB?=
 =?utf-8?B?Ym0wY2JKOWwwS005YjZMbS91SGtJUDZmM1N6ajFLMjVVbUZadkJsM0tqWExn?=
 =?utf-8?B?bHE0VE96RFJsdzZqTDZTdnRNMjlZcFpPcHA3NkpodHQrQVUyeUN2MXFDMnc0?=
 =?utf-8?B?TDhpUmtpMWJxOXhETVZReXlrUlZkc1M0aHN1cEtBM2k3WjYvTFVIVENQNWh5?=
 =?utf-8?B?V0VRZTA0WFhHY21McGJQcnpLRWtxZGkzc01TTGhpc2JDNFJQSG5jZm16QXhC?=
 =?utf-8?B?M1VuOGdlSGVlZFpvRkpIbDZnWlZnRXl2QVNMbS9xTzYzbzhrcktjU1dyMExG?=
 =?utf-8?B?Yi9xbE84NThXWE9rMHM3WmpKQTZmcWlxckhQeUI2VnBLN3hhMzBPRTJ4UktU?=
 =?utf-8?B?Q3I4Mks4bjJxNU5VdGNnYUExWEI1K2ZYZXZ0K0dYQjhicXV6TVc0N3ZuOC9B?=
 =?utf-8?B?dmIvQzdWU25VeHBoYkVFTzNhU2hMUUlTNjdCMC9jUE1FMWFzenZNaVdkdnFN?=
 =?utf-8?B?djZFVFJaRmw4SkhiRW52WGZtRXRPblE2aXN2ejM1L2pHNWQwR050bkdBM1JB?=
 =?utf-8?B?cTVQVDRPQ1BrdFM4amlPa3RPa1RaV1ltRjkvK0c5NUNSRmJYbGJ4TGpBT3hp?=
 =?utf-8?B?b2JDMWRTMEt1NDBTZ3AzTHdFRkRJVUNLWm8zOThsMm9ZaVJCWU5yM1gvdGkr?=
 =?utf-8?B?L0FLbVd5QkZDbjROdk9SR0pEK1Z4dzQ3SEJnM2tRcjkxNjFzb083M1FVc0xZ?=
 =?utf-8?B?aUZEenlEQVh1d2oyRkQ1cVExcFp6L1hlM2FtZEFuenFsZkFQYkwwZmlxcEhI?=
 =?utf-8?B?bnZBblBuWThMVVBpNTNLTkdkVXNmVDBFM2V2VGY4d3N5aGpZOHczbGNRSTBh?=
 =?utf-8?B?bnJWMlR0dVJiRzJvWnNLU0RnSmRLaGxXbXlPb2RGdmhYNUdKUnFNdGJXakZN?=
 =?utf-8?B?RTFMOGRqamJxZnBwbFB0M0VxWFo5MHpaNGhWSmRxRFo4eU9ybUY1S0Q2dUxT?=
 =?utf-8?B?VE1lQTNrdkF0eDV3cGJ3YlBINlhMemFGdEs3d2ZOdDMwdXcxWEYrZnRJYlE2?=
 =?utf-8?Q?iHVz6WFEYg3fADIflji4uCROfEvF0bv2QEpFcWhpu3dp?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 607c8546-5e0d-4fbe-191c-08db4589f886
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2023 12:38:28.7691 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 56kmbMNtxn3YQxu8Cp6UH1qZQVWIWwoPfl2jvaZhoAccpJQ6S9s0TYDYP8U3n2sx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6049
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 pierre-eric.pelloux-prayer@amd.com, contactshashanksharma@gmail.com,
 arvind.yadav@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 24.04.23 um 19:38 schrieb Shashank Sharma:
> The userspace sends us the doorbell object and the doobell index
> to be used for the usermode queue, but the FW expects the absolute
> doorbell index on the PCI BAR in the MQD. This patch adds a function
> to convert this relative doorbell index to the absolute doorbell index.
>
> This patch is dependent on the doorbell manager series being reviewed
> here: https://patchwork.freedesktop.org/series/115802/
>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian Koenig <christian.koenig@amd.com>
> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 33 +++++++++++++++++++
>   1 file changed, 33 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> index 385cd51b6c96..fbc9cb5c24ad 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> @@ -44,6 +44,30 @@ amdgpu_userqueue_find(struct amdgpu_userq_mgr *uq_mgr, int qid)
>   	return idr_find(&uq_mgr->userq_idr, qid);
>   }
>   
> +static uint64_t
> +amdgpu_userqueue_get_doorbell_index(struct amdgpu_userq_mgr *uq_mgr,
> +				    struct amdgpu_usermode_queue *queue,
> +				    struct drm_file *filp,
> +				    uint32_t doorbell_index)
> +{
> +	struct drm_gem_object *gobj;
> +	struct amdgpu_bo *db_bo;
> +	uint64_t index;
> +
> +	gobj = drm_gem_object_lookup(filp, queue->doorbell_handle);
> +	if (gobj == NULL) {
> +		DRM_ERROR("Can't find GEM object for doorbell\n");
> +		return -EINVAL;
> +	}
> +
> +	db_bo = amdgpu_bo_ref(gem_to_amdgpu_bo(gobj));

That looks like we are leaking the object reference here.

Christian.

> +	drm_gem_object_put(gobj);
> +
> +	index = amdgpu_doorbell_index_on_bar(uq_mgr->adev, db_bo, doorbell_index);
> +	DRM_DEBUG_DRIVER("[Usermode queues] doorbell index=%lld\n", index);
> +	return index;
> +}
> +
>   static int
>   amdgpu_userqueue_map_gtt_bo_to_gart(struct amdgpu_device *adev, struct amdgpu_bo *bo)
>   {
> @@ -133,6 +157,7 @@ static int amdgpu_userqueue_create_gfx(struct drm_file *filp, union drm_amdgpu_u
>   	struct amdgpu_fpriv *fpriv = filp->driver_priv;
>   	struct amdgpu_userq_mgr *uq_mgr = &fpriv->userq_mgr;
>   	struct drm_amdgpu_userq_mqd_gfx *mqd_in = &args->in.mqd.gfx;
> +	uint64_t index;
>   	int r;
>   
>   	/* Do we support usermode queues on this GFX IP ? */
> @@ -154,6 +179,14 @@ static int amdgpu_userqueue_create_gfx(struct drm_file *filp, union drm_amdgpu_u
>   	queue->userq_prop.hqd_base_gpu_addr = mqd_in->queue_va;
>   
>   	queue->doorbell_handle = mqd_in->doorbell_handle;
> +	index = amdgpu_userqueue_get_doorbell_index(uq_mgr, queue, filp, mqd_in->doorbell_offset);
> +	if (index == (uint64_t)-EINVAL) {
> +		DRM_ERROR("Invalid doorbell object\n");
> +		r = -EINVAL;
> +		goto free_queue;
> +	}
> +
> +	queue->userq_prop.doorbell_index = index;
>   	queue->queue_type = AMDGPU_HW_IP_GFX;
>   	queue->flags = mqd_in->flags;
>   	queue->vm = &fpriv->vm;

