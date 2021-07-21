Return-Path: <SRS0=ovQZ=MN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E3A3C12002
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Jul 2021 16:53:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FAE561222
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Jul 2021 16:53:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FAE561222
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C3D8C6E85C;
	Wed, 21 Jul 2021 16:53:58 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2046.outbound.protection.outlook.com [40.107.243.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E9046E85C
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Jul 2021 16:53:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XSsIYrQSvmml/R0TSXLO7xWxC78kcdyHu+jvPl8B9Ru9D8pyXnkj9Y5HUAUAEqzhx4EA9fpXpXKQBt4X/1+4h4ekanUdgOXu3vgAdQIGAfAchOFYEvyTsk9D4MN5ee1DPb2bVHuNLtybkNRUDs85/yDRy91BLo7vBc5IE9iwNBhu7Z5abqr1720npNb3Wfyxd0IAuY3HAEldxoSeSLRcGEzXlpzkeKhgIyT90PjMb+b6Qy65H3Keq2w9YylMadQVO+rLvPveAVVkamU8otkm2HA4uuBXOcJePJFWzeK8eQy5cyKqklmXD0cRrT0UwYoYFMjkiZvTqyJT88ix7Hkh5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TyDqKmTupJcg6F9+frlMhUSKMYxC2ZI/qxHI2FzvUXA=;
 b=h98qzODepNONdPsA5L0BEjdZXEPbrsICDJDrJxHM2hAzy6FbfWxIDkXDqqbe/fKfMiPIr0wpwWHA6BcfmovGfLrdOeA/n2xqhJeyFJP0X9S7NDWG0oQ2uh7MTRTcWxrTcLa4SoWiXTCf7NvsZ1ArXkA/ZM0T05tEGDhXbbrphbcoEvd4AszKnZ54dwi79I84TeeZZxCd6EDV+9HQm076u/k/bHqpLgNhCJHJpf87FxHbCYiBaryi03NwIAZxAG4ngLxT0rr7t9jMeiAYdRSgrftoiaJtQxKVlG6rKFzugrIuqMoUAgz5WsyFImJaOZPqebj8Gn12jftcoviaCo58tQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TyDqKmTupJcg6F9+frlMhUSKMYxC2ZI/qxHI2FzvUXA=;
 b=qg+aKXr+GV4TnVdXZdhEZuPEbuwhtIB2DyiB64LEtP2Lbc48/00dXLhDHW8GTbCHtCe+G5NNumBlf29yrTU/j8wUEK7cWtRrUsm7lRcopo5Zyu16Dyz3FC9FpURFjatqkS3Fn1Y6v49SHYN0O3x11p9heN5o5DksR55MfLu6hGs=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB4623.namprd12.prod.outlook.com (2603:10b6:805:e9::17)
 by SN6PR12MB4767.namprd12.prod.outlook.com (2603:10b6:805:e5::32)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.26; Wed, 21 Jul
 2021 16:53:55 +0000
Received: from SN6PR12MB4623.namprd12.prod.outlook.com
 ([fe80::9f8:ec71:6535:cd36]) by SN6PR12MB4623.namprd12.prod.outlook.com
 ([fe80::9f8:ec71:6535:cd36%5]) with mapi id 15.20.4331.034; Wed, 21 Jul 2021
 16:53:55 +0000
Subject: Re: [PATCH 2/2] drm: add tdr support for embeded hw_fence
To: Jingwen Chen <Jingwen.Chen2@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210721031352.413888-1-Jingwen.Chen2@amd.com>
 <20210721031352.413888-2-Jingwen.Chen2@amd.com>
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Message-ID: <36f53a64-2d9c-947b-a5fb-21d9fc06c5e4@amd.com>
Date: Wed, 21 Jul 2021 12:53:51 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <20210721031352.413888-2-Jingwen.Chen2@amd.com>
Content-Language: en-US
X-ClientProxiedBy: BN8PR04CA0054.namprd04.prod.outlook.com
 (2603:10b6:408:d4::28) To SN6PR12MB4623.namprd12.prod.outlook.com
 (2603:10b6:805:e9::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2607:fea8:3edf:49b0:ea12:7619:962f:f231]
 (2607:fea8:3edf:49b0:ea12:7619:962f:f231) by
 BN8PR04CA0054.namprd04.prod.outlook.com (2603:10b6:408:d4::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4331.24 via Frontend Transport; Wed, 21 Jul 2021 16:53:54 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bf40c09e-21d4-48c4-a284-08d94c68201f
X-MS-TrafficTypeDiagnostic: SN6PR12MB4767:
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB4767827D5729573300059236EAE39@SN6PR12MB4767.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VPeH2X7Zc5UQ+AdeKm2sqxld2jeiEAA8qCutQt7Uc+giY3HVzHxj7OHeA4BK0hgDiSoKYX8fM437P1TBNKNaYypz5Gjwz9D5FSH9F7EsWFtV7IZo9RJXkaXtScHwOlwtbfq5iOCoxw4tW+QeWsycRzSCLKwKXS4YGDqp4yPnLSzxN9889+OdIXh7hfgRqLKIs0PfMLpa4jyTNbQLRhOdHaY00/ZXvntixPIIMP2SWPz+w09UuJmSyXIpTrc954G1VkogyXm4iWP32nNfIEeXKekStv8MR8n5iz0axAzhAWMBvfK5jzViw4OtZEuhf6BUUbiJc8r9exz/fmfXfX3LCfKzD2tVFqHpDDTVnANDclgQLSidjx+Vc51JQyJorqH/FEkqDbNW8WSSzL+4yOrMobjhhZ3xN6oebi5oOeE6DKkB3M5/zFLa0t1Pvr9vCRAWHEWy3RytklJZugLiAVcq3Z1B8QmiSFH5ikTyEtX1j+pYq2bVyppD42oPt0x7Q/WIbrnvBVGD/7fGdO6tNjhDutXwvrtmU+TJ87hBtLdzbuGTmDv4hU3hD/FMSUvD8DAhOCmSzbDPa/70VPB9Xe2IoFTPIeRLEt153/Q+l1qkTdKrspwCwSH7Ouh6aXLrl83PvoMbICaseW6fFPdbglZoWyuYV6y96v5ndkHGckysOjZ2qcK5MBRIo0lURc6DPelZsX7RmRjY3k9Tl5uiIRGP7D3hiaLupARQb1TN+HPTPhA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR12MB4623.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(366004)(396003)(346002)(376002)(136003)(5660300002)(38100700002)(86362001)(83380400001)(186003)(478600001)(2616005)(4326008)(31686004)(31696002)(66476007)(6486002)(44832011)(8676002)(66556008)(8936002)(36756003)(53546011)(66946007)(316002)(6666004)(2906002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cUJkM2d0MlJhUlZPZ2txdTFXSU9QSGMvSGhVTGhGUm1OSWhxWitoVmlEWERq?=
 =?utf-8?B?bTd0Zzh3UlREWXh2V0VPUjNOZUZtc1RVWlBzS0d0WnppRFFrN0c3bmlXZ3lT?=
 =?utf-8?B?NkNQMmphVURpL0FteGM2N3VPNGFwTXdLMDJ0MEJrRDQ5NzdsNmU0dTJkV1Zz?=
 =?utf-8?B?V3ZDK2dXUXJMSHFDVTNyYzVIK042bEcydElHQVNRZ3JtNmw5VWk5SHJGcE9H?=
 =?utf-8?B?OXN2Q3daQTFEbEhJcHFUeTMwalFlM1QzbklMNHY3NXp6RzhXTGY3d0ZoRU9k?=
 =?utf-8?B?R1VVRGN6QzFiT01QL1V1SGJ6WDRYQ0lWS0wycDQyZEFldGkzODNSY0VVSUhF?=
 =?utf-8?B?TWR5Q1N0K0ZDWW5WemUyckNHa0wvb3JlaVdKSlZGcnh0aXFvVzFYQk9DazJX?=
 =?utf-8?B?blFZWW1vS0R4N2V6Q3EyZGt1RHlzT2w2bE82b2lVZ3RycEZNcGJyem1WK2h5?=
 =?utf-8?B?WjE1Yk9yNjZyZk44K25sR21mUG1Xb01iTElwREdVNWFjaGdTNCs3QjIrd0dJ?=
 =?utf-8?B?YW5CRnlRY3VwRXdUMHpPcDBacWlMYS83cHJ3THlnSmhNMGhXbEFDdG5NMXBN?=
 =?utf-8?B?ZzJSV3JUeENKNkdZK3Bic3pDdzRCYTdOdDJCcEdPTVBqTHZJOTV0SEJPOW9l?=
 =?utf-8?B?Mk9xSjJEUllyWUtzblRPN3VIQmhCMFdlR3E4SGx0ZmZTWHV6N0hwWlJzaU1O?=
 =?utf-8?B?NXkzT2pwSU1GNEduL00yMjJtVnJ1Vm9seHgvZk95dDgvQzhVeDJzSW5yWkN2?=
 =?utf-8?B?TTZqREtMRDljVlpnMEoxUXcraDBQREdkRWVPSWdMMVRGcnpLVXB1aXZEN2Ra?=
 =?utf-8?B?ZlNURDZnaVk2cEdvdHNRWTR2MnFoYmlwOGNPdWlnYXQxR3hJQU1SczRIbEFY?=
 =?utf-8?B?VUxxNzNhVmZuN0xHVldEYTVtNTRRbDJ1UHkwaEFseWFBejMzMmU4RUM1dDhO?=
 =?utf-8?B?V2pzdTBodzgzVGJKZTZpMEhhd1IzbUtjcWtEanAvK1JXK0d3VFFmTlhhMGxj?=
 =?utf-8?B?M29JU0ZRWEJsOWZRUmtaZml6b3htaTExdFhnaEVoeDRRRll0N0tsaW9MRUhh?=
 =?utf-8?B?YXJNTGF6R1MvR3FDbmxaSnhaWHNmT1N3eG55cjh3YWlISzdabnIwNGdNdkpa?=
 =?utf-8?B?VTE4ZUF0YUdsYmE0U0pKZkwvSmxnWCtNYVA4dXZwazZlMXQ0dkd6RzdKY0hY?=
 =?utf-8?B?R3VxY0JEblA5cXBweFg0Y1A3aUZjMVNqd2ZGZVl4OGdVa29rOHFldVNpd05j?=
 =?utf-8?B?YnpwK1RLYU0xbzhXdWZINzAvWlBGeVdBWWk4dXZROWZBMkx0Nnp2ZDhJVE9q?=
 =?utf-8?B?QzNLSHJmMXBGS3RaZG93V1gyNFM2Z3d0Y3pjSDlCVW9YNy8rQlFkRStmb3VD?=
 =?utf-8?B?VDE1dnNFWk1JaFJ5VkhxTzlSeU04dUwwbytRK0tlTWNqU2djYlhrNUxRVjFF?=
 =?utf-8?B?MXcyUzE0Z0F1aDNnQ3ZNWnhsa1VPREpYT3AvK09FZ1V2emJCaWEyVlR0cWhI?=
 =?utf-8?B?L0JjaHFIa09haWh6R1BsRk5EWWJmRkUyWHFYRFpsTG01aERVWGtBeTRINWtO?=
 =?utf-8?B?TytkdXJ5TlNtR0syWVpGQnczdmY2TXcrMDRmbDdDK08xeWVNN2FkeTkzREEy?=
 =?utf-8?B?d2ZRby9xQzZ6UE5NVGtDbGJ1UGYrdVJhenB1SXA1R3dHckxHOWs5bHRhTW5V?=
 =?utf-8?B?Nk1lYzJrSm9TVkNHSEFmcU5oMFBWNmU1MEpyaFpOMktZc1BxQ0c4bG4rU0hS?=
 =?utf-8?B?NzBMTjhXazI2Y3dUaEI5UzlQWFAyaC8yQzNYTENEaWdLM0Z4QTVxcm1jVGJE?=
 =?utf-8?B?cWZ3VnJUaVdhZTB5SmtmK0s2MDNMRjBFZGdTa1IwWmYzekdGYlBMcFZPTk5i?=
 =?utf-8?Q?4rtooWNanCitj?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf40c09e-21d4-48c4-a284-08d94c68201f
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB4623.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2021 16:53:55.1608 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kuo+xwrche7EC4ZJysuyOgG18/d1a0zbGZPDs2Fyt7EgVKUCsX3PsyOWkfw7TUqpETAcm7rP7ho0PHZCJ2o99w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB4767
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
Cc: ckoenig.leichtzumerken@gmail.com, horace.chen@amd.com,
 Jack Zhang <Jack.Zhang1@amd.com>, monk.liu@amd.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 2021-07-20 11:13 p.m., Jingwen Chen wrote:
> [Why]
> After embeded hw_fence to amdgpu_job, we need to add tdr support
> for this feature.
>
> [How]
> 1. Add a resubmit_flag for resubmit jobs.
> 2. Clear job fence from RCU and force complete vm flush fences in
>     pre_asic_reset
> 3. skip dma_fence_get for resubmit jobs and add a dma_fence_put
>     for guilty jobs.
>
> Signed-off-by: Jack Zhang <Jack.Zhang1@amd.com>
> Signed-off-by: Jingwen Chen <Jingwen.Chen2@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 12 +++++++++++-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c  | 16 +++++++++++-----
>   drivers/gpu/drm/amd/amdgpu/amdgpu_job.c    |  4 +++-
>   drivers/gpu/drm/scheduler/sched_main.c     |  1 +
>   include/drm/gpu_scheduler.h                |  1 +
>   5 files changed, 27 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 40461547701a..fe0237f72a09 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -4382,7 +4382,7 @@ int amdgpu_device_mode1_reset(struct amdgpu_device *adev)
>   int amdgpu_device_pre_asic_reset(struct amdgpu_device *adev,
>   				 struct amdgpu_reset_context *reset_context)
>   {
> -	int i, r = 0;
> +	int i, j, r = 0;
>   	struct amdgpu_job *job = NULL;
>   	bool need_full_reset =
>   		test_bit(AMDGPU_NEED_FULL_RESET, &reset_context->flags);
> @@ -4406,6 +4406,16 @@ int amdgpu_device_pre_asic_reset(struct amdgpu_device *adev,
>   		if (!ring || !ring->sched.thread)
>   			continue;
>   
> +		/*clear job fence from fence drv to avoid force_completion
> +		 *leave NULL and vm flush fence in fence drv */
> +		for (j = 0; j <= ring->fence_drv.num_fences_mask; j ++) {
> +			struct dma_fence *old,**ptr;
> +			ptr = &ring->fence_drv.fences[j];
> +			old = rcu_dereference_protected(*ptr, 1);
> +			if (old && test_bit(DMA_FENCE_FLAG_USER_BITS, &old->flags))) {
> +				RCU_INIT_POINTER(*ptr, NULL);
> +			}


Is this to avoid premature job free because of dma_fence_put inside 
amdgpu_fence_process ?
I can't currently remember why but we probably want all the HW fences 
currently in the ring to
be forced signaled - maybe better to test for DMA_FENCE_FLAG_USER_BITS 
inside amdgpu_fence_process
and still do the signaling but not the dma_fence_put part

Andrey


> +		}
>   		/* after all hw jobs are reset, hw fence is meaningless, so force_completion */
>   		amdgpu_fence_driver_force_completion(ring);
>   	}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> index eecf21d8ec33..815776c9a013 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> @@ -156,11 +156,17 @@ int amdgpu_fence_emit(struct amdgpu_ring *ring, struct dma_fence **f, struct amd
>   		job->ring = ring;
>   	}
>   
> -	seq = ++ring->fence_drv.sync_seq;
> -	dma_fence_init(fence, &amdgpu_fence_ops,
> -		       &ring->fence_drv.lock,
> -		       adev->fence_context + ring->idx,
> -		       seq);
> +	if (job != NULL && job->base.resubmit_flag == 1) {
> +		/* reinit seq for resubmitted jobs */
> +		seq = ++ring->fence_drv.sync_seq;
> +		fence->seqno = seq;
> +	} else {
> +		seq = ++ring->fence_drv.sync_seq;


Seems like you could do the above line only once above if-else as it was 
before


> +		dma_fence_init(fence, &amdgpu_fence_ops,
> +				&ring->fence_drv.lock,
> +				adev->fence_context + ring->idx,
> +				seq);
> +	}
>   
>   	if (job != NULL) {
>   		/* mark this fence has a parent job */
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> index 7c426e225b24..d6f848adc3f4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> @@ -241,6 +241,7 @@ static struct dma_fence *amdgpu_job_run(struct drm_sched_job *sched_job)
>   		dma_fence_set_error(finished, -ECANCELED);/* skip IB as well if VRAM lost */
>   
>   	if (finished->error < 0) {
> +		dma_fence_put(&job->hw_fence);
>   		DRM_INFO("Skip scheduling IBs!\n");
>   	} else {
>   		r = amdgpu_ib_schedule(ring, job->num_ibs, job->ibs, job,
> @@ -249,7 +250,8 @@ static struct dma_fence *amdgpu_job_run(struct drm_sched_job *sched_job)
>   			DRM_ERROR("Error scheduling IBs (%d)\n", r);
>   	}
>   
> -	dma_fence_get(fence);
> +	if (!job->base.resubmit_flag)
> +		dma_fence_get(fence);
>   	amdgpu_job_free_resources(job);
>   
>   	fence = r ? ERR_PTR(r) : fence;
> diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
> index f4f474944169..5a36ab5aea2d 100644
> --- a/drivers/gpu/drm/scheduler/sched_main.c
> +++ b/drivers/gpu/drm/scheduler/sched_main.c
> @@ -544,6 +544,7 @@ void drm_sched_resubmit_jobs_ext(struct drm_gpu_scheduler *sched, int max)
>   			dma_fence_set_error(&s_fence->finished, -ECANCELED);
>   
>   		dma_fence_put(s_job->s_fence->parent);
> +		s_job->resubmit_flag = 1;
>   		fence = sched->ops->run_job(s_job);
>   		i++;
>   
> diff --git a/include/drm/gpu_scheduler.h b/include/drm/gpu_scheduler.h
> index 4ea8606d91fe..06c101af1f71 100644
> --- a/include/drm/gpu_scheduler.h
> +++ b/include/drm/gpu_scheduler.h
> @@ -198,6 +198,7 @@ struct drm_sched_job {
>   	enum drm_sched_priority		s_priority;
>   	struct drm_sched_entity         *entity;
>   	struct dma_fence_cb		cb;
> +	int resubmit_flag;
>   };
>   
>   static inline bool drm_sched_invalidate_job(struct drm_sched_job *s_job,
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
