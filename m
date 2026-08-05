Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73778C55174
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Aug 2026 04:45:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E3E9610E14D;
	Wed,  5 Aug 2026 04:45:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Ij1fIGRy";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013008.outbound.protection.outlook.com
 [40.93.196.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6418810E14D
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Aug 2026 04:45:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k+Oy2Vg1EywwpKoSvJ9wwxCBvH7xODpiPgpMG85NRHPZQpHPeRvGKEDPLgia13s9Uy53581s7JP2foqr6KRlClUaJCPlCtrZJR6XJPZh1FPlP/oNdIA7zzhyj3qma3/imyETI5xRPcRkXLf1KRjCRu1Vnu7ILcYbGYOQzV99hmgPDaHBnQRYx3HXO3Pbkaqp/TlO+jxGgZasTfbr1n39YMcA55EEm0BbmuC66tlkjRyLdFnVyb6aLu5FT46W06Y9QO/LC3etTMNufqP22OIpkPG+EJtjCLyc9rsBOQ5Avb7WcrBKwAG/DhtgBOFV9xFVO1SdXFjzA/4VJLTl0qCGyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FzQE6rqufEE8AIKH6wtf6t5+xxSJ4RxavrVY13YtTK0=;
 b=Y60JfljuYPM0AtlfSyl1wd+sL+BGyiVE/W01uHH2CutGlUkZoLC/7K/E0pm5uBMdNLUBvfDcUanAx8HWiNixgxvF2uzFOioBux5sO6NcBFQ7S2jXCfFMKsE2XjAT8hk/6RoVqwXk8xXKP1+lrUOkKqYX8O1as6yyCK9sga8B27bz2GWZ8SPF0N0h+s3ANjyEWFTDtQbgPlPzWhkb6B4j/eRR0IUgSkJOW0btqZ6vX6zNDoZ74vp96q+gIbEqvGobojOa/XX9zBEjAMAd+gjlYf73yF+eli7dg/LiDuYIqP2BKh+7s84qBRF7IiQ8/yTuvnqyR5DTFBbgvEPdNExGSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FzQE6rqufEE8AIKH6wtf6t5+xxSJ4RxavrVY13YtTK0=;
 b=Ij1fIGRyOujhfgZeuS1ihP19N5M++tz4CUvfxjAJt7t+tz5exW+V+s5CrMi6OP8YRojuyda5IkR0hYS5FTcNToeed4wnfpBUX0XShGrbWaRGd6EevsTOo6trtGjQ+IVih1M8UtnqsU2r4pK39u9jIr67VSggz/jDXZP7uMuEc6Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN7PR12MB6767.namprd12.prod.outlook.com (2603:10b6:806:269::8)
 by BY5PR12MB4084.namprd12.prod.outlook.com (2603:10b6:a03:205::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.16; Wed, 5 Aug
 2026 04:45:44 +0000
Received: from SN7PR12MB6767.namprd12.prod.outlook.com
 ([fe80::ef05:8207:37d5:53]) by SN7PR12MB6767.namprd12.prod.outlook.com
 ([fe80::ef05:8207:37d5:53%4]) with mapi id 15.21.0270.016; Wed, 5 Aug 2026
 04:45:43 +0000
Message-ID: <1d4d5817-40c0-4b8b-a9f7-8c6b4d577688@amd.com>
Date: Wed, 5 Aug 2026 06:45:40 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdgpu/userq: Add syncobj_points to signal ioctl
To: amd-gfx@lists.freedesktop.org
Cc: Christian.Koenig@amd.com
References: <20260519125844.33399-2-david.rosca@amd.com>
Content-Language: en-US
From: David Rosca <david.rosca@amd.com>
In-Reply-To: <20260519125844.33399-2-david.rosca@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0397.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:108::16) To SN7PR12MB6767.namprd12.prod.outlook.com
 (2603:10b6:806:269::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB6767:EE_|BY5PR12MB4084:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a9f8d80-dfb0-4979-4cf6-08def2ac6898
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|22082099003|18002099003|11063799006|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: YlAY6ROxpCK1VTuRtH/XPUtWXZbwosmM1QRfytdKrKnClv263wURrz0eIHy9+Qa/5DyPHgovC3GkEmzcNARcYBHHM34NzXfDWOyy3wK67EcXd5hgukn1jXfZ3zy1oAZw6tCLDtdYAeqyMamrjyBB+hM9hVijNNLJgutr0MnkiIqnovNVUMHVI2c2cCr+SKjueMfN+y2EMUHtU04Bl4f+CAjO8nm4mxiZAOuxcpa/CSf6BBoYxN4oJUJ3Dj/2tupMtfmJahljWlJxplUFaXrgVVzITt4wjOftNZxnS7oZa/uEJn0Q62pAy5zAlcHLUFJrgVTg11eIrfQUY2gUli/7tpG+NEA2kspF2J83uDbke2OUo42SSmSLp8vv7+ZHDe6p2x5qiywYBmh/fEXNoYwPSiq2MlBvZQPATuRDztM09ZRTCQoPxzgkc1USNwrNbHWZAtJkoA/UECshwbszrJNjfHl+cK9rhplqHBeW6vzbhIkYS2oLUWYX0Gua4ytGHg1aHsEl4+XJCcTRKJkJJAUvPKfBr8LHcRbN91MLBKIvhqUf3p7hTyhxoVIXwTpyz2JYF7DBU3hfHJqIdjDhBR8IT4qOmHsDIaJY38NNeSImfOw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR12MB6767.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(22082099003)(18002099003)(11063799006)(56012099006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SkcrNUw0dlBmM00xaFNHZEhWaUlhS2ZiOXlIc1FOYmtsc3VxZ1Ryc1AxYmg2?=
 =?utf-8?B?Z21FMVdrNlM4ZHU1VVRnbkVTdEd6TXVEMmg5Q1NRcU00T1dsemNYKzBHeDFD?=
 =?utf-8?B?K1pRWjR3c2N2YXNaNWJHM3dEdStkbXd4MTVYTmVBS0w5dVlBa0VWaEh5b3Uw?=
 =?utf-8?B?S1ZKQUVrTXc1aDFXdDR3WUU3UlJ2WllTY0l3dTVrbS9zY0p3UTZQQmRlNDV6?=
 =?utf-8?B?cFZSNTFreUdrSzZLTE93VXlOSFlpckMyZUttcHM1RnBSRWg4RUZFbkltM1Q4?=
 =?utf-8?B?SzlnRDRubElLTUFlaUIveUg0TXFYRElISC95N0hjRmZvTGpwUXJXTXVVUGMw?=
 =?utf-8?B?b0lJZ1lWQmsrejY5QjFvdmF0MlEvRHlvT2RKWXlMNmdDY1FuQ0VjR255ZHB5?=
 =?utf-8?B?WldXL3l6UFRqc3dKNWVZTjNNOFlQZnpZTXR3eTJETnpqb1dFWFJYTjVhaVJE?=
 =?utf-8?B?bUZHWU9SMTdERVZMcTJ4WEZxRUgwWGJRREFYVmVZYTJTQzJHSXV5VHdqcGV3?=
 =?utf-8?B?bGx1VUFoTTBqc3V2TWtSc3R4M3pTa0h4SndBS1Z0RzRIQ2xnSkdEaG1tZ2JG?=
 =?utf-8?B?M0NVbjRVZGl1WHVWY1drNVRFaXlaUnJqNnpYdTJwSVZYQ096cTJuT21YcGFD?=
 =?utf-8?B?NEpqSHY4eGlocHE4NDMybC9SaUJQYlhjS1dLUW9tWW94d1VQdlBDSC83cVdR?=
 =?utf-8?B?SE9nV2J6ekp4S1I2TWpibmxBTnJYcXllVXBXeTluVzU0YzV4Y2VMeE05YTBS?=
 =?utf-8?B?Q2x2S1pRK3RhdXRDNkZWSmVrbFhYTytBd1NMdGtUd0JjZ0grZWFQa1UwZGM1?=
 =?utf-8?B?SmRCZjRHcGNmWGcwN3NzWXNOcE15RkVETEk2M3ZxSEVhcWh1eFE3c2xuOUhG?=
 =?utf-8?B?aDhDZkpXc0d6cUEwRGJJdjdXZzcwMVRkYzNQTWZrZnZ2THdpa3FtRFFneSsx?=
 =?utf-8?B?Y3BjNElpNnoyMWVhSVhXYTh4dittZmFUVzV5LzZoR2drcHpPdHVjRnRtZWh5?=
 =?utf-8?B?aTVGbkdPS25GYWV2MEZHaWlHQTM0Q0E3SmtKR3VRbnZ5WExpdkpBRVh1blBW?=
 =?utf-8?B?eDlSTVZWcndiRG5BM1VjMCtPS0NpbGNlNXB6bi96dmpKS0lpdVhvWEhqcGli?=
 =?utf-8?B?ODJST1VvYktCd0EyQUh3eUd3K0RHN3BOYmZCdFEwOWQrM0E1aU45a2FQL0V5?=
 =?utf-8?B?ZzQ3TkFhM1JERWJQMllPcmdzT0tqVEw3a0gzM2N6b05CYjN0WWxaNjRGZlZo?=
 =?utf-8?B?YmtTZEpZVVpTdG9FMEN3dGMrOUt6NTJOeEExUndHVnlKNjJ1cGdXeVRFeG0w?=
 =?utf-8?B?b1Q2SHNWL2EvTFdIMWJncTJ0WHNDM2ZJa3hablQyTlhjTXVoWEhTRk9iWHZI?=
 =?utf-8?B?NFlMa0lYTTJZNlpSTVdJbVFUY3AyeS94SjhKNTQ2ODFQd3dkNVpLZ3BiamlY?=
 =?utf-8?B?aDhIQkFtdThlYmEyMWwxdnFOTEpneTQ3ZHE5UFNQZ3FUNzlaV2V3dGpUMVpB?=
 =?utf-8?B?ZThSRW9iKzRLS1pYelB5NEFDSS9FbDFvelZpUE9VWkxZcjVqMXprczR1eWF3?=
 =?utf-8?B?L1RJYlJNNEhsZk5ia2tyNWZyZVA4RlRIZ29CNVh4ZnQ0Ukd5amZadVdFYzEw?=
 =?utf-8?B?dlh5clhUMmpqcE9jL0l3SHJJWTlsNUdDQlFhb2VWaXU2Y1U1dUswUVFQRmJ0?=
 =?utf-8?B?WjJUbG95eVB3ck50VmtsMTVOMklwRElUSldwa1R6YjNheFpNc1EyZjd4Q29M?=
 =?utf-8?B?L09tdjZqQkRzS09qYmd5OXk1V0x3TmpuQWZOR0ZSTlhCdVg0TWpmZWtjbmMv?=
 =?utf-8?B?WXBKVmU4RW5ha1J1NzhvYTVjdlBKVlpsK2VycExlOVRqOStOcXVFMVJ4eGhy?=
 =?utf-8?B?UEIxVDFoRW9GRkpLdVBjMVNCOFdSQUFwNi8rNE9QL3RkR2VlQWxqUG5HSWxj?=
 =?utf-8?B?MWF5SHl6NmpDU3ZwdVBnOXpPbUhaWUozN0FWaFlaNXUxaWhzSHhlSUJZdVQy?=
 =?utf-8?B?UmNRWEV3eGp0VzZWZnB2aGRVMCtQdnVOMmtzYVVQNmVaWHFLc0w5UFJ3MnpK?=
 =?utf-8?B?YVFwUzlsbmdUNHBkYjZkYkFMVWZEcmVwYmwyTmFVNngxSVlMa3hENzRqeXhI?=
 =?utf-8?B?cGJVVDg3Z0NxWVJ6ZUwxdmZOTjVReVdRRlI0cUFYVVhOZnJobnBmU0xHbFBD?=
 =?utf-8?B?aDFGd1FKdktSTGNFbjV5TE9kSG5CL0pTS1kxajdVWWE2RlFxc2krNzdFVG9Z?=
 =?utf-8?B?TFBWYnpOS3l4VTdYMVA3MVhaVUJGVEtaMWdNcTljOTRoNUsvZUJkeHNUMkJW?=
 =?utf-8?B?N1lYd3VXeDcxUWNTTEVpZ1d6NnFpOHRvRDdFWHc1YlVQOXV4Yk5zQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a9f8d80-dfb0-4979-4cf6-08def2ac6898
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB6767.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2026 04:45:43.8441 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dfsoBDh/k20Abp6/DjPtOjBtKrSC3JstN0qFphOrB3GembL+lEsZ/O2/bPr8QJhVFv1RMVTANn8cdjISb9gNIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4084
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
>      fixed syncobj leak when dma_fence_chain_alloc fails

Ping

>
>   .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   | 50 ++++++++++++++++---
>   include/uapi/drm/amdgpu_drm.h                 |  5 ++
>   2 files changed, 47 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> index c0d68863fa17..f4366c5d1e35 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> @@ -460,9 +460,13 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
>   
>   	struct drm_gem_object **gobj_write, **gobj_read;
>   	u32 *syncobj_handles, num_syncobj_handles;
> +	u64 *syncobj_points = NULL;
>   	struct amdgpu_usermode_queue *queue;
>   	struct amdgpu_userq_fence *fence;
> -	struct drm_syncobj **syncobj;
> +	struct {
> +		struct drm_syncobj *syncobj;
> +		struct dma_fence_chain *chain;
> +	} *syncobj;
>   	struct drm_exec exec;
>   	void __user *ptr;
>   	int r, i, entry;
> @@ -482,19 +486,38 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
>   	if (IS_ERR(syncobj_handles))
>   		return PTR_ERR(syncobj_handles);
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
> +
>   	syncobj = kmalloc_array(num_syncobj_handles, sizeof(*syncobj),
>   				GFP_KERNEL);
>   	if (!syncobj) {
>   		r = -ENOMEM;
> -		goto free_syncobj_handles;
> +		goto free_syncobj_points;
>   	}
>   
>   	for (entry = 0; entry < num_syncobj_handles; entry++) {
> -		syncobj[entry] = drm_syncobj_find(filp, syncobj_handles[entry]);
> -		if (!syncobj[entry]) {
> +		syncobj[entry].chain = NULL;
> +		syncobj[entry].syncobj = drm_syncobj_find(filp, syncobj_handles[entry]);
> +		if (!syncobj[entry].syncobj) {
>   			r = -ENOENT;
>   			goto free_syncobj;
>   		}
> +		if (syncobj_points && syncobj_points[entry]) {
> +			syncobj[entry].chain = dma_fence_chain_alloc();
> +			if (!syncobj[entry].chain) {
> +				drm_syncobj_put(syncobj[entry].syncobj);
> +				r = -ENOMEM;
> +				goto free_syncobj;
> +			}
> +		}
>   	}
>   
>   	ptr = u64_to_user_ptr(args->bo_read_handles);
> @@ -561,8 +584,15 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
>   		dma_resv_add_fence(gobj_write[i]->resv, &fence->base,
>   				   DMA_RESV_USAGE_WRITE);
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
>   exec_fini:
>   	/* drop the reference acquired in fence creation function */
> @@ -580,9 +610,13 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
>   		drm_gem_object_put(gobj_read[i]);
>   	kvfree(gobj_read);
>   free_syncobj:
> -	while (entry-- > 0)
> -		drm_syncobj_put(syncobj[entry]);
> +	while (entry-- > 0) {
> +		drm_syncobj_put(syncobj[entry].syncobj);
> +		dma_fence_chain_free(syncobj[entry].chain);
> +	}
>   	kfree(syncobj);
> +free_syncobj_points:
> +	kfree(syncobj_points);
>   free_syncobj_handles:
>   	kfree(syncobj_handles);
>   
> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
> index 9f3090db2f16..ad643b41982c 100644
> --- a/include/uapi/drm/amdgpu_drm.h
> +++ b/include/uapi/drm/amdgpu_drm.h
> @@ -502,6 +502,11 @@ struct drm_amdgpu_userq_signal {
>   	 * @bo_write_handles.
>   	 */
>   	__u32	num_bo_write_handles;
> +	/**
> +	 * @syncobj_points: The list of syncobj points submitted by the user queue job
> +	 * for the corresponding @syncobj_handles.
> +	 */
> +	__u64	syncobj_points;
>   };
>   
>   struct drm_amdgpu_userq_fence_info {
