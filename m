Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B908EC5CFC1
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Aug 2026 09:18:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0461510E1D3;
	Tue, 11 Aug 2026 09:18:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TJieGHU9";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012054.outbound.protection.outlook.com
 [40.93.195.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E9DD10E1D3
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Aug 2026 09:18:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o+hx06WgYwOK1QKtHhtyGKJRlXaS6doOeJpBbnKXxGjohW5K4fMU9e+70Q3ltuDEmXyNz2x/bhfpwahVXJf/VtiVAI3bImI0ByiKfVFR/fXqKPo36IjkgCPcLshhd7us1kqjcVlDzPLpNBMhWwyytjErJ5+15ln2lGWLDyZdkvi/3PSVGtULwpanhyM7z69CuR1UuRFLlivljotzvhPV//Mp1G4aFvYI2CNb7hvp8km6V7w5DPJLKytcmBHUxQnUSM/W6kJRZz5exwRsN//xZNOXE4ImzA5zL09p85SEJ88QZkjiNtwyEJQP7FySTqIPkdYByJtaRekGZE5HcEqIZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HTAXl7AFA5kmKaHufubPgHyoLi7u3GkLEJpVPKSF0eE=;
 b=cfdGZnhvuaXaVsVAkE7nzZUAjFjyKaIQUkF8EhiB6yQKweP0zaaF5qYDiPt0cK5gGdG18PsDXr0VbClk0Zco4SeP1veHEdic0FlFGoZPYQxWddvUCCbAi8qWb8AaULNjKAsbJIcGB7NDFmv80VFxwas9XG1vPSuTwaHUeSdvurYOZ2OMdc1JUhZdJ54ppAwr5vBEvVX2hS7Ixcq1eesdiw4LuberHMRNk8b34BAYQkPmIXYGR8DI/CT1OAgOn2gkvvYAq24Lnu4ggsdm/PubOgSNFHD4jAqERvWInK1jSHHiTRyCg7RliU6+5CfoDaiWfKKmzbDAAVCa4o/ollcjoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HTAXl7AFA5kmKaHufubPgHyoLi7u3GkLEJpVPKSF0eE=;
 b=TJieGHU9Muc9Rl9kQr4jFkQw1vTAxHuOg9TVHhwVYPRJZSkiJDU8rw7lM7Ho7tpddeWWNTZM9p4ss1otFvUDgY2YnF888J6dy3KmXvlxUUj3Jay5L/3I+VxHQj+ZdCiQ8ur+fv2idBXC0VT8OcbgrcSzRuSJxt8T82Ib+1IcZFI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CH3PR12MB8972.namprd12.prod.outlook.com (2603:10b6:610:169::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Tue, 11 Aug
 2026 09:18:16 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0292.024; Tue, 11 Aug 2026
 09:18:15 +0000
Message-ID: <3e8bb4b1-effb-4d59-b9a7-2acfc2be6217@amd.com>
Date: Tue, 11 Aug 2026 11:18:09 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdgpu/userq: Add syncobj_points to signal ioctl
To: David Rosca <david.rosca@amd.com>, amd-gfx@lists.freedesktop.org
References: <20260519125844.33399-2-david.rosca@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260519125844.33399-2-david.rosca@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1PR13CA0301.namprd13.prod.outlook.com
 (2603:10b6:208:2c1::6) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CH3PR12MB8972:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a5f76f0-40ba-4c97-249e-08def7897815
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: IpUN8Jy05i0o8sV5zp2xf+YEC97X/X1EhLM2zbM0C9MDSwX/goxeOVlnTOE2R59hT0bwoRj2CkS3v+fp3aIf9Zq4hB3LBYG3HYqqTrrNJycmM3G1bYrtXMk6mU7KTUA3reNcudlt0XwNH97KAu88Bx6r9XMpjqkDkNURFI70kgfHR7TGhj1Kbq6ptAa+zj9eW5SZVRpArElV8MNB8vubYCjV72HwpNtvK6yHpF3Tc9h+7WQ95pAV63Jo/aBml7mEypmtX3u7HBj1Kn6TGdFfCP6wjkzyXTFGnxdLMaswffv7IhcYziNLDe1G2udc5A6hQGI1adQtkl11eQBidruVtCT/Kpr6f1UW2D2aWZk45w5sCWcEER4jNqfVfvnXg3OEHYZ09MSkd6B2DQfjDCjh9dJsLHyxq3cMjYRpDoTKyMOOVPGssYi9bFvlPJx1W0lFuFukRkr4+RQ/xQN74V90OnisDoR2qlwxGdx2g5SF4/gVQrQWFLgJQ40mHMlp4d7SX5ExgMfpCKuffuB+x3c8fmQ5bF1teSemZwTUf/b1F9K2Ax1krM20efKe4La1m9aIDN1QJm4lGBJZrNIwpS7lbaemsh33J/UehGJk2NOrhkCPdSNIC3PM/bM0eLKFUHv7rg9Kn71q3Vd7DsRQx8gAbq19EZeqycW+H8vKWq/jY5A=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MXFTQ1Z3OHBYY0twaXEvMDMxNHU3dTZ1d1dUdTJ6MkxZTkh2bkIzUjZMT21W?=
 =?utf-8?B?MEFuVWJmRzFFSVp4djYrZms4NnMwNHc5Y3RSU1pOd0Z5UG5tazJRMTNSSlh2?=
 =?utf-8?B?WW9PdUNXQkVRMDRVQmt2SnUzZGhsV285ZDZ5NXBtMEdVVCs1TDlMNlRnS2x0?=
 =?utf-8?B?ZzViN2EwZ1YxTzdyZWhwNXBjR0pMRG1YZGFyZDdWdVYxNGpoUk9hVG5hWnJa?=
 =?utf-8?B?WWFFbVZRQXhLa2hFNjg4L2FlZFBMaktYdmRob0M5VDN4aUUzVTdKOWFUbHFo?=
 =?utf-8?B?Ynpxbmc2QSsxejNOeElBd3l2dmc0M29KM3BQOUVVV0FCUys0OFhMVCtOQTQr?=
 =?utf-8?B?ZTNIY3lYSkhvZWs3K05CZGdYVUlTZmtYRXN3L1dia1ViOEVOUlZuaXNXVi84?=
 =?utf-8?B?Mi9ibFdRLyszL1hkMU5rK29LMW5jLzhpdm0zMER2L1E5ZE1tNmpyQVdhcHUv?=
 =?utf-8?B?L1VBRzdnOGY5akx5VFVOVnZsSDBxa016dFJUcnVYUndoQUdzN05PMThOdktL?=
 =?utf-8?B?MWxRRkFiUG9tMVRyTWViQ2JFZlpuQ2VmL3hLUk4yVEs2b0xMTkoyZDZmSUR0?=
 =?utf-8?B?L1lHREZ1dHMySW1pYkxPeVB3cHdUUHpTbVlTQnBtTXhPMHpoMEVaa2o0UEJF?=
 =?utf-8?B?bzFSQVpKbUtENHVXbUxqejZpNnVvUzhKd3M2VlFCdGRmY29FS0xVWnZ1dUYw?=
 =?utf-8?B?QThCZmVxWEFIalBlcVNaNzkzL05IUDVvVldEUENZNThMTkxBSGtNRk83dXlv?=
 =?utf-8?B?MEpYQk1jeGNwNDNsNXNxM3pxVVA3U2RzcTdjK0VjaUpQVUJYUTNYRStZS01a?=
 =?utf-8?B?WEs5WXh0SFp4UkdBT0FJZXVoQlZNZGgzOXVxY1VqLzdDTml0MkZFZTc1WGNq?=
 =?utf-8?B?ZWlMQVFOMU82U3lGdHMrL2xsbnBRTTdFWVdYbUtkTjhabzJlRkhDcDc2cFp3?=
 =?utf-8?B?TGNKakFjSUlXUWRpSFF3cWsvalhxR0lzY2YxOHJyMnBmSmF6V0pXb09TU2px?=
 =?utf-8?B?ZTBrblhmaVVrUmp1bVJuTFpCSHRZTDM2bkZwcTV2WWZETVZJZnNDNWxHTVdG?=
 =?utf-8?B?QVZYZ0xNQk5XeXAwbVlsZnFaNllBUG1zcUVmeTVaSHUvckYwU3dFcExpaHdm?=
 =?utf-8?B?cmRXWGpQWXpRNDEzV1lWQnlNNlg1SEkxaFlFLzQvUTRzN3J5RVdmVDAzTUIw?=
 =?utf-8?B?UUVoMkFDU2RoaFM0ckxyRWd0cVBCTzMxdGtNcit1YVZNK3lSVXBsTVpqTFRE?=
 =?utf-8?B?U0g3RnpYTCtMTlFDdU0wbmhqRk1hZTRRU2ZiTGJING9KTjBlTWJUaGgrczZR?=
 =?utf-8?B?SWlGdmZraThrVmRYWGNtQzJ1TitBK0R5a25na0N1KzBFMkw3K0xZbzhkd3Qy?=
 =?utf-8?B?VDl0akNpZW9ZRzQ5SWdwVHZrcEFpaVFtaW9qVmlYV1g0OGo2RlhFb0hzdWZL?=
 =?utf-8?B?UFI5N3k1Z20yR0FvTUZxOGVGemhvN2ErZTNjYmdZTUk2TUZNNlVSdWR2eDli?=
 =?utf-8?B?bHR0VW1RNS9SNHNVbFJUTW9VVVZEQ2NkVGtHR2FUSXZKL0RVS3RVc3N2RlhN?=
 =?utf-8?B?OEFtcDVRSUFUSjIxbkVrNlMyNWVaNUxtS1VzOXlNOEh5NGVWaEp5UjBDalh1?=
 =?utf-8?B?WWlwckwxVmlrcDB4OFFjMC9sWVIrdFRSNFJhclFZT2JWZVlGY1F5Qm9aQTJr?=
 =?utf-8?B?c2JKbExLSWdURVd1SXh4TkhHdXNxbmUrSVgvZ2c0K0FOOEJVUGw3M1QrVEZz?=
 =?utf-8?B?ZmV2RHUySUpvaGRQbk9oL3VHeThzUTNMeXRPcTQvNHNFVHgvWUtSNWZGUjEz?=
 =?utf-8?B?UHdCUXo1S0w3RVJVOUF1RndrWjZtSTkwdmQ5c0VBM1JycktkOWc1SEYyRDJh?=
 =?utf-8?B?bFBuZHRuaThZZWpLTkFVdkM0ZEdpbVh0ZEovOG5MQmZ0Kzk4d0pMMG8wWG96?=
 =?utf-8?B?R243L0RXbmVKdjJRLzdBNzdhaE9HTjMvQUVvbnJWbHEyc0JuQm5iYjZMRFdD?=
 =?utf-8?B?ZFhOaUluMnR2c0VKZmgxNWNERm83cGN1VXpwVW5aS1pSQUN4UGl2cjVvWGZK?=
 =?utf-8?B?ek81cWJ3RmdrSCtBOWlub0pIRWhORUp6dWthVVlET1hBNnhIcTJDSUFpY2ZY?=
 =?utf-8?B?NXRqQzc0NlpsT2gyLy9TMVRqME9Tb3ZycVBDbVJrcFkrc1R3dEkrdlBERFRn?=
 =?utf-8?B?am1PTkhORVdCYzNEcWdSeTZwQUZ4eHlpTnZWOTdUanRDbGVRa0JyQXZUVkdC?=
 =?utf-8?B?Tkl0QmtMRS9KMGVvTmQwZFVoL3Y5SjR6R0szb2N2dkorbllCRkFwb1NIanZl?=
 =?utf-8?Q?iHhSpm+AGgvN4O8pij?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a5f76f0-40ba-4c97-249e-08def7897815
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2026 09:18:14.6479 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kzyRJNGI5f7LETq0up1Hvq+3dimjPLjjmdvHwxZ2YsM5p7PVG158DP7L/hW8vxJh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8972
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

On 5/19/26 14:58, David Rosca wrote:
> Userspace patches:
> 
> * radeonsi NV_timeline_semaphore
> https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/37335
> 
> * RADV user queues
> https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/40808
> 
> Signed-off-by: David Rosca <david.rosca@amd.com>
> ---
> v2: don't use struct amdgpu_cs_post_dep
>     fixed syncobj leak when dma_fence_chain_alloc fails
> 
>  .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   | 50 ++++++++++++++++---
>  include/uapi/drm/amdgpu_drm.h                 |  5 ++
>  2 files changed, 47 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> index c0d68863fa17..f4366c5d1e35 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> @@ -460,9 +460,13 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
>  
>  	struct drm_gem_object **gobj_write, **gobj_read;
>  	u32 *syncobj_handles, num_syncobj_handles;
> +	u64 *syncobj_points = NULL;

Don't NULL initialize that here.

>  	struct amdgpu_usermode_queue *queue;
>  	struct amdgpu_userq_fence *fence;
> -	struct drm_syncobj **syncobj;
> +	struct {
> +		struct drm_syncobj *syncobj;
> +		struct dma_fence_chain *chain;
> +	} *syncobj;
>  	struct drm_exec exec;
>  	void __user *ptr;
>  	int r, i, entry;
> @@ -482,19 +486,38 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
>  	if (IS_ERR(syncobj_handles))
>  		return PTR_ERR(syncobj_handles);
>  
> +	if (args->syncobj_points) {
> +		ptr = u64_to_user_ptr(args->syncobj_points);
> +		syncobj_points = memdup_array_user(ptr, num_syncobj_handles,
> +					    sizeof(u64));
> +		if (IS_ERR(syncobj_points)) {
> +			r = PTR_ERR(syncobj_points);
> +			goto free_syncobj_handles;
> +		}
> +	}

Instead add an "} else { syncobj_points = NULL; }" here.

With that done Reviewed-by: Christian König <christian.koenig@amd.com>.

Regards,
Christian.

> +
>  	syncobj = kmalloc_array(num_syncobj_handles, sizeof(*syncobj),
>  				GFP_KERNEL);
>  	if (!syncobj) {
>  		r = -ENOMEM;
> -		goto free_syncobj_handles;
> +		goto free_syncobj_points;
>  	}
>  
>  	for (entry = 0; entry < num_syncobj_handles; entry++) {
> -		syncobj[entry] = drm_syncobj_find(filp, syncobj_handles[entry]);
> -		if (!syncobj[entry]) {
> +		syncobj[entry].chain = NULL;
> +		syncobj[entry].syncobj = drm_syncobj_find(filp, syncobj_handles[entry]);
> +		if (!syncobj[entry].syncobj) {
>  			r = -ENOENT;
>  			goto free_syncobj;
>  		}
> +		if (syncobj_points && syncobj_points[entry]) {
> +			syncobj[entry].chain = dma_fence_chain_alloc();
> +			if (!syncobj[entry].chain) {
> +				drm_syncobj_put(syncobj[entry].syncobj);
> +				r = -ENOMEM;
> +				goto free_syncobj;
> +			}
> +		}
>  	}
>  
>  	ptr = u64_to_user_ptr(args->bo_read_handles);
> @@ -561,8 +584,15 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
>  		dma_resv_add_fence(gobj_write[i]->resv, &fence->base,
>  				   DMA_RESV_USAGE_WRITE);
>  
> -	for (i = 0; i < num_syncobj_handles; i++)
> -		drm_syncobj_replace_fence(syncobj[i], &fence->base);
> +	for (i = 0; i < num_syncobj_handles; i++) {
> +		if (syncobj[i].chain) {
> +			drm_syncobj_add_point(syncobj[i].syncobj, syncobj[i].chain,
> +					   &fence->base, syncobj_points[i]);
> +			syncobj[i].chain = NULL;
> +		} else {
> +			drm_syncobj_replace_fence(syncobj[i].syncobj, &fence->base);
> +		}
> +	}
>  
>  exec_fini:
>  	/* drop the reference acquired in fence creation function */
> @@ -580,9 +610,13 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
>  		drm_gem_object_put(gobj_read[i]);
>  	kvfree(gobj_read);
>  free_syncobj:
> -	while (entry-- > 0)
> -		drm_syncobj_put(syncobj[entry]);
> +	while (entry-- > 0) {
> +		drm_syncobj_put(syncobj[entry].syncobj);
> +		dma_fence_chain_free(syncobj[entry].chain);
> +	}
>  	kfree(syncobj);
> +free_syncobj_points:
> +	kfree(syncobj_points);
>  free_syncobj_handles:
>  	kfree(syncobj_handles);
>  
> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
> index 9f3090db2f16..ad643b41982c 100644
> --- a/include/uapi/drm/amdgpu_drm.h
> +++ b/include/uapi/drm/amdgpu_drm.h
> @@ -502,6 +502,11 @@ struct drm_amdgpu_userq_signal {
>  	 * @bo_write_handles.
>  	 */
>  	__u32	num_bo_write_handles;
> +	/**
> +	 * @syncobj_points: The list of syncobj points submitted by the user queue job
> +	 * for the corresponding @syncobj_handles.
> +	 */
> +	__u64	syncobj_points;
>  };
>  
>  struct drm_amdgpu_userq_fence_info {

