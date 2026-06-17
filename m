Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4969CD98F2
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Jun 2026 17:04:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4753310E2A3;
	Wed, 17 Jun 2026 17:04:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Ai3WUUbC";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011053.outbound.protection.outlook.com [52.101.57.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 66A7710E2A3
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Jun 2026 17:04:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mBHutpsN4WEQIQl0bY3hpB2aikr1Zo9zCU8sy1MufXFS3F7awu9QGNOfkvOyuGOWpvbAIV4b95K48GeN24NGeQSembimu1QVIVbvTXHHUTRMHVrLdd9NYJ0BgXGz1mHkMv95lm38LHZoFmdNhPzZ43Tv/q1j9zW1pTcBM0lWned2vu53S1+YxPtNEcHA2AYb+H3qnOF+6r5VHeSXf2k8kAn8MqnA7ld+zjNkTAdCUXvzLRqS9kF8OrCLgTWflzlyTnfln2E5Br2jr3/q1jBVwavWeqbCqLFbLkpCgnVVjqVr1xU84n3G5TlcRTs7J65CE7W2hgYIZ20Ewt4WuibMtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=97mVddB2ckL7R4O7xXy/4FSn9+Li+HaLGtC/o5M3aUI=;
 b=duNo2KVaL+pWBeLc6rPHXfCm0I4Ez4TdGwFoLbc+d85buGhjQ8P1P3YSNP85XXnT9fTEncc200ELPF7zN74n+oHtboIv1QqB1Ys1BtMMXPrPJirCrNUElpH7TP/MQYnLXl1MijmrxiUcyZ7ku1jl6TabDtDDrEHziJfrZ25ccJporqrNil8pF4oIjB9DbpaO/UOcEPtRO8sgnKJ5v/Mxa0rrsNX6JNdcHgWFDPQ+cXMsOKFSJ+lCaZBWxgiRaHUjCAKJADsrIbjcgKA6Du5n+nbVQYH+zIUByA0F+9BG/wwGyxQj7D1HuzsGTAplPb60nn32fZ9ueFzDOaZcTt+v1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=97mVddB2ckL7R4O7xXy/4FSn9+Li+HaLGtC/o5M3aUI=;
 b=Ai3WUUbC/uEMEvyxttZWPqC7/6cKgFfifBCkuYfgVEmbNWSRQ7cebNPz3i5M+hgOwP3bcAWde81yGiErFRKV8xW30Q+cfaRxplIsT/i/ToBP6QQ2i5Cd/rBn2Tw4uul1yeU3ISmgibtjoZXtsgdGu55FIQlX6LURsqGzfC8EU58=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::607) by CY5PR12MB6177.namprd12.prod.outlook.com
 (2603:10b6:930:26::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Wed, 17 Jun
 2026 17:04:11 +0000
Received: from BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 ([fe80::e2a6:da85:2544:e542]) by BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 ([fe80::e2a6:da85:2544:e542%4]) with mapi id 15.21.0139.009; Wed, 17 Jun 2026
 17:04:11 +0000
Message-ID: <ff4f2a99-17c0-4538-bdb2-512e7f51f62c@amd.com>
Date: Wed, 17 Jun 2026 13:04:10 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/amdkfd: Drain retry faults before SVM range
 no-access unmap
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org,
 Harish.Kasiviswanathan@amd.com, Amir.Shetaia@amd.com, Kent.Russell@amd.com
References: <20260616211652.1962285-1-Philip.Yang@amd.com>
 <20260616211652.1962285-3-Philip.Yang@amd.com>
Content-Language: en-US
From: "Kuehling, Felix" <felix.kuehling@amd.com>
In-Reply-To: <20260616211652.1962285-3-Philip.Yang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0034.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:fe::16) To BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::607)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PPF5F16C5C9C:EE_|CY5PR12MB6177:EE_
X-MS-Office365-Filtering-Correlation-Id: 8dab52ae-3116-4dcc-6921-08decc9273f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|23010399003|1800799024|18002099003|22082099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: h+vGdPt+ZHBRRshnlctjPPGd0ej8621+m1n2QSjpSxWHuAzKsDvfiFvmeDE3ISphY7tYua8C1RtqrPN6TbO5SzqaY8z303Jfdgtqh8aqgoNnTPLX3COPkEB+keBTiPhwU369EjNIobUCn7MDPk7Vt36Mpyfrk/X3gKGHyH5b5y+ArX3zNhL3xCF9waIDnTLxgZJZKS14plVsuau/Zvn+pyTKGiwEeoApNNasJ0nLqc4QdojUvKHy1JTwWBUOMYoD80dhNCJXIVfnSFbRfF4Ep8MEfGu2hPhmXFzEWHmxO3HGz0BXsBEAkUwel2zyQzBnGSyWbYocHLUEfzQPvlz9KLkSZYBdQKMiQEDjq70NKXE0ww6ZYfE1k/TvbGpmfN5bmBFlrV17r+pLBQi+yV8P7IPA+9kGt5aHx+4VpXAtyDIDN10S+2JcIiPgHTyR5I6j4KSHE5b5JrhiQ9i5beZiaLBy6ML6QqW5v03xb/dCHhIb8ODSupmaNymBPyMXzJ2sHM9D6s7O82B9aOGzQIhaQ0bTbL4PdPvLeohsstmpJHEFcxsDQ5scToKE4yW/OcZtZfLLBqJf3Gm7sFHaRAfTow7aXN3CwCd8xbWjRyJqyD8SNSUs5m8pJXgkUO0h5XvTN9jduKg5I5GRkDrrdoJ1ncxq2DxxrvVz58+OmIVss7dMhclGcrOxSaGqDgEBxggL
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PPF5F16C5C9C.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(18002099003)(22082099003)(4143699003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S1FZbTZaenZYY0tyN3hoT21pajN1QUdzSUpoS2Y2MFV2eURqNWwzQVBCaFlM?=
 =?utf-8?B?V0wxWXhKTHFncmYwcVFXTkJXUVVuL2tqME1MVXc5Q3lHendsbkZJbThwMnI2?=
 =?utf-8?B?THlERzE0c2xtL2FmQ0R0Tm5vUXZ0aWw4Y0t5aERZRzhMbklVRFVWSUlMcFQx?=
 =?utf-8?B?alkzK0E1U3dFSGRMNllZaVJMRS9CbHFDMHJpd0dWNU1yaGNUTjNEd3R6cFhL?=
 =?utf-8?B?MHJoNGpjOVJIVXU2Ry9SS1FFT3czN0JQN0c3WnovR2N2Zm50bEUyT2ozZW5Q?=
 =?utf-8?B?L3N3SWFBYzlkQWs5ZDNOSVQ2WGh2NkJRd051VG1sU2c5MXU3Vk1pT2RiM2ZU?=
 =?utf-8?B?RDVjazhiays3SUp6Zk5kaUp3WXBLTkZsZmhJU2I3ekg3WkZkYUwzZ2pUeFJE?=
 =?utf-8?B?VDZMYmVhV0hJaEY0MWdRWkVueGYzWXlyekRnaEEzSGwrMFJNNFBxMUJOeG56?=
 =?utf-8?B?c1QxQ3BZMDZCYjdzWitlMU9sMWRyWDVZVXF3anlQcmNjWWJhb1AxcWZqUmZB?=
 =?utf-8?B?Q1ZQSEpVSGd4UTZhNzNwVjZ4UytWOGtmTFhYb1kzNEpQZ3dWcEh0c3lxUkx4?=
 =?utf-8?B?ZFhYV1lrQm8zYlRzV0VDZnNSK2JFdk1GMXFiVFRqa00ybzQ4NDJubXVmWmhI?=
 =?utf-8?B?eXh2RUpFR2xJclJ5SWdaODhFb1RGaURnUWhkWlBpMmNIUlpxRnFsWUw0NVpP?=
 =?utf-8?B?bmtDb01aNk91MmRXZFhKdWlJb3FIR2d1Mm1CZnBwamJoV2VhN1RJVVRzV3dR?=
 =?utf-8?B?dSs0WGlkMzVxWHVPczZvRWVqQjQ3dGhVRnN0eTRTaTQ0WjhTR3JzMkEvWWlj?=
 =?utf-8?B?YzZRVW9FVllEUmVMZDNDaCtsMGNsdG5ETStzYk1sYTg1L1UxSWpoMHB5Unpk?=
 =?utf-8?B?a1RRdjVzK1JPQ1pKdlVwR3FoNFQwYUM3eDBBK2dtMy9qd0dibXlrVWczVGRy?=
 =?utf-8?B?elJqa1BTeWgxc0t6dTAvL21VOXlucC9Fb3JyQjRCUmdyOVVETE9RRzRrVjRN?=
 =?utf-8?B?c0lrT0xlNXRXdTE3SkdvUlp2Y3p6UERRc2w5emx3dlJMTUpZeE1idUxrQzRF?=
 =?utf-8?B?dVZqL0ZXMDBQdVg2NjIwQ2huVjNFU3JhRHFqMnpLZlFyR21QZU93Lzh1em8y?=
 =?utf-8?B?dDkraW1mQzk2ZWJpZkc0c1AyYTlJS1hrNVZ1YUh2Z3BZOXV3S1RvZG9WaWxo?=
 =?utf-8?B?QlQ1K3YzUExUckVZSUJxVk0zbjFqSEJnNURkRVdyc1BwYVduN0lZZTBhc2hh?=
 =?utf-8?B?MFN6d1Iyb05pYmpSVVpyY1ptZldINGhVZVhxd1FwK0lmYTZsQmhPZGVwUGVJ?=
 =?utf-8?B?OVRSWFJBVXdJTGhjNXJ4K0tiMnk5Zkc1NkUvdnZPbm5wSkJYdFZZYUpYRW5P?=
 =?utf-8?B?L25ZVUs0Ry9oK0JyNkdZcnhOc2ZIblVOUGlRSXZaOXp3eHdWenNCOW1EOTVz?=
 =?utf-8?B?V0NlRWUxa0dMZUdqZDRnTHBibko0VVU1NVlOUGliT1NyMmxQK1F3cFlDZ281?=
 =?utf-8?B?STR2N3U1Tnd3M2w1NXlOSWdobTNhZnNsRmxrblFMdUJrcHFBcnJIcnZ3bEtx?=
 =?utf-8?B?ZmdVcjVxVHhmNXpMQTVYMFJuY3kybjN5d3R3U3VhNHBPZFZtdkNnNkZ0dWxo?=
 =?utf-8?B?Y3VGcDVVY2gvbzZDb3lUb1dURlZhZjJVaXlZa2tBOU9ENEdkN05IaFVFSlBE?=
 =?utf-8?B?d05FcDcydVNWaXA4WjhJWlhQVGFETEszMzNFMzBVNThDODV4UmNkQmtMMlNM?=
 =?utf-8?B?S214OU9vaUhDL3o4eDlHTzArV1lBb2R6WTRpV2tndXhYUko4Rjk3QjUzbXdo?=
 =?utf-8?B?MjF3QTloOVB0VWdzaDFrYUJYTnVpL041bThUbHFOQlJ6S2xvUWhuL0s0anhL?=
 =?utf-8?B?NDFzTUlnVWM2ejI3WGxYYmlUL3UwM1dBTVNUWVZjMndVYUZ0YUc1T3ZtejB0?=
 =?utf-8?B?bi82cWJULzBKMHdtK1Bzc1lJb3NtaU8zTnRqYkp2ckNMWlpoOXpBY0lwaHR5?=
 =?utf-8?B?bmRHK3VlWml1THhVelVkMXZvY09CbVN0VzcxUEg5YjFvRjZ2d043Vlp1ejhy?=
 =?utf-8?B?S2V6Y2lHMzE1TEdyakxydzRIcjFTU01aSTIwSVVyeWJkYUhOdjdQL09RYnFw?=
 =?utf-8?B?ZFA5R2M1YzRKbHlNZHJKdE41YjlVYzRGaGxvcGpXRHNSMjY3WGMyd3RWTXIw?=
 =?utf-8?B?T1hsajlDUE9aM01EaUJIU3ZYYjlsbENLcDVLdjlmRkNpMENoQnNHRWhEZzRH?=
 =?utf-8?B?Y0tLK1B3MkdrZ2x2QU1zOFRCaENNMzFJVUZKVDVXV09lcGhrT1VBamd1T3Mr?=
 =?utf-8?B?TnBpUFlVTDZma29BYzRvZWdCT29DellmendvenRKcGRXT3RZODhtdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dab52ae-3116-4dcc-6921-08decc9273f2
X-MS-Exchange-CrossTenant-AuthSource: BN7PPF5F16C5C9C.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2026 17:04:11.7193 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L+mWpAdz31YaGK2gLYzr585rtOTMYymd/SGDbJISvBu3aWspegm9/yeoj/xsShpz19mJ7xym/n1SjWSqXLSFhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6177
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


On 2026-06-16 17:16, Philip Yang wrote:
> When svm_range_needs_unmap() unmaps a range, retry faults queued in the
> soft IH ring before set_attr no-access was called must be dropped, since
> those faults arrived before the app chose to revoke GPU access and should
> not re-map the range.
>
> Extract and add helper svm_range_update_checkpoint_timestamp() from
> svm_range_unmap_from_cpu() so both callers share the same logic.
>
> Change checkpoint_ts in svm_range_list from uint64_t to atomic64_t so
> svm_range_restore_pages() can read it safely from the page fault handler
> without holding the svms lock.
>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
> Acked-by: Kent Russell <kent.russell@amd.com>

Looks good in general. Two small suggestions inline.


> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h |  2 +-
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c  | 85 +++++++++++++++------------
>   2 files changed, 50 insertions(+), 37 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> index f00c522fba74..d3dcc3b8d546 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -893,7 +893,7 @@ struct svm_range_list {
>   	DECLARE_BITMAP(bitmap_supported, MAX_GPU_INSTANCE);
>   	struct task_struct		*faulting_task;
>   	/* check point ts decides if page fault recovery need be dropped */
> -	uint64_t			checkpoint_ts[MAX_GPU_INSTANCE];
> +	atomic64_t			checkpoint_ts[MAX_GPU_INSTANCE];
>   
>   	/* Default granularity to use in buffer migration
>   	 * and restoration of backing memory while handling
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index e039b6f2942f..acaa364244d0 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -759,6 +759,48 @@ svm_range_check_attr(struct kfd_process *p,
>   	return 0;
>   }
>   
> +static void svm_range_update_checkpoint_timestamp(struct kfd_process *p)
> +{
> +	struct svm_range_list *svms;
> +	int i;
> +
> +	svms = &p->svms;
> +
> +	/* calculate time stamps that are used to decide which page faults need be
> +	 * dropped or handled before unmap pages from gpu vm
> +	 */
> +	for_each_set_bit(i, svms->bitmap_supported, p->n_pdds) {
> +		struct kfd_process_device *pdd;
> +		struct amdgpu_device *adev;
> +		struct amdgpu_ih_ring *ih;
> +		uint32_t checkpoint_wptr;
> +
> +		pdd = p->pdds[i];
> +		if (!pdd)
> +			continue;
> +
> +		adev = pdd->dev->adev;
> +
> +		/* Check and drain ih1 ring if cam not available */
> +		if (!adev->irq.retry_cam_enabled && adev->irq.ih1.ring_size) {
> +			ih = &adev->irq.ih1;
> +			checkpoint_wptr = amdgpu_ih_get_wptr(adev, ih);
> +			if (ih->rptr != checkpoint_wptr) {
> +				atomic64_set(&svms->checkpoint_ts[i],
> +					amdgpu_ih_decode_iv_ts(adev, ih, checkpoint_wptr, -1));
> +				continue;
> +			}
> +		}
> +
> +		/* check if dev->irq.ih_soft is not empty */
> +		ih = &adev->irq.ih_soft;
> +		checkpoint_wptr = amdgpu_ih_get_wptr(adev, ih);
> +		if (ih->rptr != checkpoint_wptr)
> +			atomic64_set(&svms->checkpoint_ts[i],
> +				     amdgpu_ih_decode_iv_ts(adev, ih, checkpoint_wptr, -1));
> +	}
> +}
> +
>   static void
>   svm_range_apply_attrs(struct kfd_process *p, struct svm_range *prange,
>   		      uint32_t nattr, struct kfd_ioctl_svm_attribute *attrs,
> @@ -784,6 +826,8 @@ svm_range_apply_attrs(struct kfd_process *p, struct svm_range *prange,
>   			gpuidx = kfd_process_gpuidx_from_gpuid(p,
>   							       attrs[i].value);
>   			if (attrs[i].type == KFD_IOCTL_SVM_ATTR_NO_ACCESS) {
> +				svm_range_update_checkpoint_timestamp(p);
> +

I think we should only do this if we're actually unmapping something. So 
maybe move this into svm_range_needs_unmap.


>   				bitmap_clear(prange->bitmap_access, gpuidx, 1);
>   				bitmap_clear(prange->bitmap_aip, gpuidx, 1);
>   				bitmap_set(prange->bitmap_needs_unmap, gpuidx, 1);

And maybe make "bitmap_needs_unmap" conditional on whether it's 
currently mapped. (in the previous patch).

Regards,
   Felix


> @@ -2560,7 +2604,6 @@ svm_range_unmap_from_cpu(struct mm_struct *mm, struct svm_range *prange,
>   	struct kfd_process *p;
>   	unsigned long s, l;
>   	bool unmap_parent;
> -	uint32_t i;
>   
>   	if (atomic_read(&prange->queue_refcount)) {
>   		int r;
> @@ -2580,38 +2623,7 @@ svm_range_unmap_from_cpu(struct mm_struct *mm, struct svm_range *prange,
>   	pr_debug("svms 0x%p prange 0x%p [0x%lx 0x%lx] [0x%lx 0x%lx]\n", svms,
>   		 prange, prange->start, prange->last, start, last);
>   
> -	/* calculate time stamps that are used to decide which page faults need be
> -	 * dropped or handled before unmap pages from gpu vm
> -	 */
> -	for_each_set_bit(i, svms->bitmap_supported, p->n_pdds) {
> -		struct kfd_process_device *pdd;
> -		struct amdgpu_device *adev;
> -		struct amdgpu_ih_ring *ih;
> -		uint32_t checkpoint_wptr;
> -
> -		pdd = p->pdds[i];
> -		if (!pdd)
> -			continue;
> -
> -		adev = pdd->dev->adev;
> -
> -		/* Check and drain ih1 ring if cam not available */
> -		if (!adev->irq.retry_cam_enabled && adev->irq.ih1.ring_size) {
> -			ih = &adev->irq.ih1;
> -			checkpoint_wptr = amdgpu_ih_get_wptr(adev, ih);
> -			if (ih->rptr != checkpoint_wptr) {
> -				svms->checkpoint_ts[i] =
> -					amdgpu_ih_decode_iv_ts(adev, ih, checkpoint_wptr, -1);
> -				continue;
> -			}
> -		}
> -
> -		/* check if dev->irq.ih_soft is not empty */
> -		ih = &adev->irq.ih_soft;
> -		checkpoint_wptr = amdgpu_ih_get_wptr(adev, ih);
> -		if (ih->rptr != checkpoint_wptr)
> -			svms->checkpoint_ts[i] = amdgpu_ih_decode_iv_ts(adev, ih, checkpoint_wptr, -1);
> -	}
> +	svm_range_update_checkpoint_timestamp(p);
>   
>   	unmap_parent = start <= prange->start && last >= prange->last;
>   
> @@ -3121,8 +3133,9 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
>   	mutex_lock(&svms->lock);
>   
>   	/* check if this page fault time stamp is before svms->checkpoint_ts */
> -	if (svms->checkpoint_ts[gpuidx] != 0) {
> -		if (amdgpu_ih_ts_after_or_equal(ts,  svms->checkpoint_ts[gpuidx])) {
> +	if (atomic64_read(&svms->checkpoint_ts[gpuidx]) != 0) {
> +		if (amdgpu_ih_ts_after_or_equal(ts,
> +		    atomic64_read(&svms->checkpoint_ts[gpuidx]))) {
>   			pr_debug("draining retry fault, drop fault 0x%llx\n", addr);
>   			if (write_locked)
>   				mmap_write_downgrade(mm);
> @@ -3132,7 +3145,7 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
>   			/* ts is after svms->checkpoint_ts now, reset svms->checkpoint_ts
>   			 * to zero to avoid following ts wrap around give wrong comparing
>   			 */
> -			svms->checkpoint_ts[gpuidx] = 0;
> +			atomic64_set(&svms->checkpoint_ts[gpuidx], 0);
>   		}
>   	}
>   
