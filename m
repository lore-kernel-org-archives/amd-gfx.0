Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 769CAEBFD10
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Apr 2026 08:07:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1222310E368;
	Mon, 13 Apr 2026 08:07:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bIbP/b82";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010015.outbound.protection.outlook.com [52.101.56.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E844410E368
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Apr 2026 08:07:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sEfwRSDsjSslaSnIE6vGbn76M4i0bJKbKNPo4AB9FjqTsMqRmHsgdsMki0Z3rDzcG18movEDFA41lXL4Xt8IQkd28LIUflrkHAYFFP5TdEKrPjRTm6t5kNdVVjWs5X8yzu9WXp/6Z0/QFYs3RXd0QTMSQ9fLexg/XBt0Ov2NmkJoU/4nFvVysqU52byBWarA5ZeZTz3sVevqItQNcdgso0wO7urK3h9bHxI1oAkf9oV/8+2nYQpYt0nwNzcKtKtmM6MvMQur66Cryu6OdWBGhpf9c2+8eS4SHX4EXP8fgg0fSHtNeqIOKsRg62LFDUKf5VcoBpO1iae8Jk9K45lI+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ED2US8Qf7/3LWw6pEI27omh4qjRr2a9e64FmnC8vAfs=;
 b=Q+xAGO/a3yVxZhokuAkxRryU1pBohBGIHgk7dH2B0AwLpLDxNcTdKO8pXnmQZUkY4mPiaBmaOU9/oRQhiLPRtHkaOpq+vXJXFBc/l6fWnM22tRgyPVvpSCegBzvbirDLc6+3arLKBP8k1oTAWRUowgw9zUvfaTY+bMO5VkU0QhJEK5MyCAYVO6juq9kqfKdbCbGyEm41tYPjShK/7QJMhD7a8g7ySqo/0zjEZ4sEfk/u/d76tCDCgsZz+kx0/cOupSp2uLKy2y10HOflFjtqqYxMvgH1qy7HOmXMWRpfZShX+9DB/2UN/ov1NAQuzf6cln8mloJRlWQwWHzLQh658w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ED2US8Qf7/3LWw6pEI27omh4qjRr2a9e64FmnC8vAfs=;
 b=bIbP/b82p2SR5KvzWY9FmCyRwyJe7OgxYP8iPmi40HM56ofehLxfjRfRrzwP7YTd8eGB9OlP7oA3H5G3rUQv34Q1f7k2EhHyeaNRnzytenVcNCzPJ2WLUjYnE32DBfr7ELLIKRAtBMiDvXKPvvZkIEm4CAI9XWtzNoZAwJb7wno=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SJ2PR12MB7991.namprd12.prod.outlook.com (2603:10b6:a03:4d1::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.42; Mon, 13 Apr
 2026 08:06:57 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9818.017; Mon, 13 Apr 2026
 08:06:56 +0000
Message-ID: <95fa0425-ae01-4b9e-bc3d-adb26b92b50a@amd.com>
Date: Mon, 13 Apr 2026 10:06:51 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/6] drm/amdgpu/userq: unmap is to be called before
 freeing doorbell/wptr bo
To: Sunil Khatri <sunil.khatri@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260413062153.4050981-1-sunil.khatri@amd.com>
 <20260413062153.4050981-6-sunil.khatri@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260413062153.4050981-6-sunil.khatri@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0119.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a3::19) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SJ2PR12MB7991:EE_
X-MS-Office365-Filtering-Correlation-Id: ae1dbf8d-8c88-4a8c-1672-08de9933a17c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|56012099003|22082099003|18002099003; 
X-Microsoft-Antispam-Message-Info: vQJMGiDW1ny2aH9756aI8+u3QGgWXbO2qPSmDZ3viAZUrqZCndV0pPlgiO/CuvYj/gaatC+uqOYshNSNsw+AebJBGOQd9dMvt15m8/sMrIhGOTi8tChZC/JmykSnJreiG/dc5wKj5DEG6iXRvYA//R/kh4B2IVPVpScE+TMt/UTsuxKjJsA50k1aCGkJW34lOVCb5R+rS9RTsRBsmCr/IqOQMO8IR/LEuKuId3tQTOGxl8k6E63W0B6Fx8SHX1QN82wnnrhQ2bzQyByvbMUHuA1v/NWMTY99EylCtL3z3/CoCHuJH/sIza7+69yCjKbRAsAp6z1vQpq6+kGRY0cMs95tb8a4aSp2/aDUwXHo5r6LcThjw9Va5vLwfIqjhffsQjr23R1ZS89HMG/fIBfqLW/FEeT0CcGMU0qoOpA7IMsTj+k4AreNQ5mGTIggkKk33Sgg/qQUUU4Xr89mfeil1twJzGPcVYBZBk0GfyvwSc99KGB+hcKUcCa68j8ObN50TSWfDuE5jrv0CjwM23bje2nSqXg704dCInua1uEacBGhiE/sg938AJjHgEu0xFmreW/vEO9ZrGqTLN7eNIPqfF39/1rT29wTqGXZChdGK6rS3NSHoqb2HtQMkJ5WWgA+4tGlmthoNQ1VjRvdTc35iHHxBzFpM74AlbdxO/qPXcNs9S38loeNhZttFDswVVTqpMrkFgW6A88P5zD5Oki6rgrDS+EaT1O/NVNEcXV/QRc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NWcvSmRLNkIzRk83YllPWkc3RlRJK2Y1NmhucVZzS3BkVzZHb3lNM2tnTWN5?=
 =?utf-8?B?T1pWUy8ydVcyS0lHM2J0OGNoRGNOZVFlNmxOMHpNYThmMmlkcUsxaS9FWDJE?=
 =?utf-8?B?dXhXSTFxTWN2L0xPTXZUczR0bnU4eW5BR290NDlTOTFtVGU0c1crSlVPQXh1?=
 =?utf-8?B?QnpWQ3p1c1czNnRTTzZiblBON3pWUFdGdktxSnA5WU01bjhIcGY4bTIrOWJI?=
 =?utf-8?B?eDJCYWVac25IV1ZaMnN4YmJrZTBiQ21hd1FhWi9xYVZsbXRzanhtc2JieGo3?=
 =?utf-8?B?SjRGSUg5RlliRlJyOHZ4S3QxaHJHeUJhZ0xsZ0lOUURMaE1PV3RySjVUQ3Ez?=
 =?utf-8?B?ZzFBdlE1bDJ0MkxDNUMrSVFVS1J0bmNtcktITytlbUc2d3h5Wnp2VUxOVnov?=
 =?utf-8?B?OHBackFvUXF3S2wyYlV0Mlp5RklVYTVmRHhHdHEycURraThTdWVuSjJmU0Fy?=
 =?utf-8?B?VGl1R0I3SzQ0MkprM1hUeE9FU1Bya1ZZYVF0Nkw0d2RiSVhlNGZOa0pPWHFZ?=
 =?utf-8?B?NU9IWW81QUNsZkswVUZrdkl5Y1l3K1FCREE0U2xWQUJ2bXExN1ZoUExkSXhS?=
 =?utf-8?B?b2hmWmVaTmxEWnIwRFFvblNlSXV5MmtHdWE3bzVON004ZXdmZjlmRDhFelVU?=
 =?utf-8?B?dHpKSVpjMUZuckx4REgvd1owRmZ3ZUxsRE9laHAvVkJ5TDhwdUZPa0pVS2lO?=
 =?utf-8?B?Tm9QWVhuWDdMNWcybnFVMjZVMXhEeFpIWUFXcjJGT1c0OTh3Z1lCYm1QOFEr?=
 =?utf-8?B?TThtdDJ4bmFUU3V2cXNYOVpUZm9rT0JlTFBFcXRuYkNvMmlEb2FVeE5UZHVK?=
 =?utf-8?B?aUxpNzFFQ1FWTmhUMEJVc1hrQWtEMFlzU3dYNkJJejJqcWJ2aTQ4SC9MVmYx?=
 =?utf-8?B?K2FuZlVaYXhneWFLdy9ZaEVjeHMwZTE2ZUZWRmhPcnZGTWpHL00zdFJ5V0ZQ?=
 =?utf-8?B?QzlvYXYrd2lWVWw0WE9EbkliQ3lUcmdrOVlQU0pTZllZOUJ0TWNWbE9NbFFz?=
 =?utf-8?B?cmhOU1NYNlRmck5mYVpuVnVqd3FHTkcwZWpmZnZCSDFta0Z3cUtSSG5MUnp4?=
 =?utf-8?B?dTVyaWUxOER5YnBobTdNd3cycnQwZVBxTStESWpCejE3NzNIVXNVMStxQk5v?=
 =?utf-8?B?R3hXaEN4QVo5R0FKUjBaL2FnUWxrcG1PTkZ3T0dOTDJoTXdpT2VxQ1BYUWwx?=
 =?utf-8?B?Z0JGRTJSMlplVXM4THFEQTF3dklJNXovVWgwTDJ3NWJNdWZ4dGdSOFpwNGo1?=
 =?utf-8?B?STEzRW1SMkRCTFVvUHU3QXl4a0MvYjBISTFqM2loNVRkQnpyOHY5OHgvaGFK?=
 =?utf-8?B?bGM2SEl6SjhxclRmMmgzc0hqNmkrTGx5R2dSRzlZNm00NU1yQis1aklRcFA3?=
 =?utf-8?B?MGx2QXFPUm5oZjNwbDNacEJOUUZSK2hhOUwrb3kwYW40M3UyVGpzeDRUaXVV?=
 =?utf-8?B?R1VSMjE0dFVqc0lvdHNyR0pkTzBMcHdhSU1MSDhCQ0daQmJ0Y21ucE5CVVlR?=
 =?utf-8?B?aWU3WnByOXZMVjY3YUdjRFpkQzlRL3l1a0pjSHh2K0ZVcDRncU16WWFTRGlI?=
 =?utf-8?B?NE5MOWhZVytBSnQ5T2hEOFdGUzZ2R0liSSthZVJleXFtNHk2UmhtU0ZPeFN3?=
 =?utf-8?B?K2lnMkU4OWovMUN4WUp5ckc2Uk9VRkQrNVc2NHJsT01EaDBnN3h0ZEN2TTI0?=
 =?utf-8?B?STVtVGlrVysxV1VadGlvdnB4T1F5LzMvSEJuM216SjJFY2xJeDlyWEZqdTVK?=
 =?utf-8?B?OTYwaUlrSndkMWZrU1JvLy92RFE0VXlOYXFHcG92Nm5aNjg1OTNvbzdGSERS?=
 =?utf-8?B?aVJ1QlZJSDh3QUpyNEVxTENEU0F2TVFxMkxZWWVJcUtFM1N6M2tSanY1elRF?=
 =?utf-8?B?Wk93UngvM2VNVTJDVnpkaktCTU44ZXZBWEFseng4Uko2a09YTGlEU09HMTVS?=
 =?utf-8?B?NElnSERKYUJ6cmQrc28vV2drS1BvTkZ5OFUwSHkvUjE1eExERWpvbjd5aWJC?=
 =?utf-8?B?U2cxU2NXTXhQOTU0QmxwNHZBZUkzdlhzcjV3aUQxU1NleEpubU1VNmF0cjQy?=
 =?utf-8?B?ODk0SGFhUk5HOWJQZmZ0ejdkd3VPS1Q4VXZ6QzRkTUIxWG42bVllRGxrdWZk?=
 =?utf-8?B?ZDYyM3A4RTU0c1pleHhkQ3NwdTJlNmFPY0lNWXJjSmJmejVLeDQycFNkbXNJ?=
 =?utf-8?B?SkwwMGIyYk5uZlhuYkFnendOdWg4b05EdEZkYWZ3amUrNWk0d3BUeVBsdkIz?=
 =?utf-8?B?M1lQT0w2MmFtTlJUeFNPa1N6cHJYUVZBeGNaazQvQ1l2R2VWQkpyZEFHdlp0?=
 =?utf-8?Q?70l8IU/CwccjGoIk/O?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae1dbf8d-8c88-4a8c-1672-08de9933a17c
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2026 08:06:56.6370 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y97moIjGI0fbRE1PknViQb3cdQQRu46WQmV5LTGVv2wN8Exe2SiwS3frGGhCJFrh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7991
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

On 4/13/26 08:21, Sunil Khatri wrote:
> Unmap the queue after freeing doorbell and wptr memory is completely
> wrong. Any operation on the queue needs the doorbell and wptr to be
> valid and hence fixing the ordering.
> 
> Also since we are using amdgpu_bo_reserve in non interruptrable mode
> so there is no need to check for its return values.
> 
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 28 +++++++++++------------
>  1 file changed, 13 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> index 6a635bb8bb30..86e7a93e93a4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -635,21 +635,6 @@ amdgpu_userq_destroy(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermode_que
>  	queue->hang_detect_fence = NULL;
>  	amdgpu_userq_wait_for_last_fence(queue);
>  
> -	r = amdgpu_bo_reserve(queue->db_obj.obj, true);
> -	if (!r) {
> -		amdgpu_bo_unpin(queue->db_obj.obj);
> -		amdgpu_bo_unreserve(queue->db_obj.obj);
> -	}
> -	amdgpu_bo_unref(&queue->db_obj.obj);
> -
> -	r = amdgpu_bo_reserve(queue->wptr_obj.obj, true);
> -	if (!r) {
> -		amdgpu_bo_unpin(queue->wptr_obj.obj);
> -		amdgpu_bo_unreserve(queue->wptr_obj.obj);
> -	}
> -	amdgpu_bo_unref(&queue->wptr_obj.obj);
> -
> -	atomic_dec(&uq_mgr->userq_count[queue->queue_type]);
>  #if defined(CONFIG_DEBUG_FS)
>  	debugfs_remove_recursive(queue->debugfs_queue);
>  #endif
> @@ -660,6 +645,19 @@ amdgpu_userq_destroy(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermode_que
>  		drm_warn(adev_to_drm(uq_mgr->adev), "trying to destroy a HW mapping userq\n");
>  		queue->state = AMDGPU_USERQ_STATE_HUNG;
>  	}
> +
> +	amdgpu_bo_reserve(queue->db_obj.obj, true);
> +	amdgpu_bo_unpin(queue->db_obj.obj);
> +	amdgpu_bo_unreserve(queue->db_obj.obj);
> +	amdgpu_bo_unref(&queue->db_obj.obj);
> +
> +	amdgpu_bo_reserve(queue->wptr_obj.obj, true);
> +	amdgpu_bo_unpin(queue->wptr_obj.obj);
> +	amdgpu_bo_unreserve(queue->wptr_obj.obj);
> +	amdgpu_bo_unref(&queue->wptr_obj.obj);
> +
> +	atomic_dec(&uq_mgr->userq_count[queue->queue_type]);
> +
>  	amdgpu_userq_cleanup(queue);
>  	mutex_unlock(&uq_mgr->userq_mutex);
>  	pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);

