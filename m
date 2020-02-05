Return-Path: <SRS0=mUog=3Z=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81D0CC35254
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Feb 2020 14:02:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20B002082E
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Feb 2020 14:02:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Kv9bsH6z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20B002082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE4606F5BB;
	Wed,  5 Feb 2020 14:02:29 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2040.outbound.protection.outlook.com [40.107.223.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E61C6F5BB
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Feb 2020 14:02:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GB/FdINJsDqdg6h9RSMOpKRi62K94alJQJlG193AnAr3dkJ396mX45OtSj8rVx4LKPfSHiPhNS+Cx5SS9knYOk4DkuqMKFS8WYgcmV4g9qES5m8pcASq+ao5kIpJEBV9UoG3nakdIr3c3lz2idOD7bP5N2SsyzV912bd7bOhp5PabRmnt3RwSY199620MAQUpYYLzlC/fjOpc5L5VXafzokp3um9UedHhD0Ho8/puUGl6BZXax1QeXTekMlBFbo6uhkImKXUg5lAJyQgEgewSYUqGy5ww41ANQuVtVRM+rEldDhOHDT7XInjLwOoN8G/HCjWm/vg22vKPsiaF/suKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JKZZQSjU0p6UFry7079IjXJ/K+Ayr1STBHgsL3rdmkg=;
 b=gBzXZ+y/Gnakk+yDpt6mSKkkvghVlshBbeiFa6KGCfa07xEWphJMUxQGCS3wjbJEqqI4d0A9fuehj5opdghULo38a5UY9tAbYiuIWAOBLKnVrp9aWaai2gvsW+eXhlPQ179ByKm5SrRanrhRfnIGgfxefcSyQAK7YohhiuCU4Mqut+VDHaCTNYoaX0uRjGvY7MeEKib5lx524gpS+sP4jBqdQsi4lxBdL83vbD0gb4n/kl/gAJBUYKw3MxqaFyUioCbXIVVnJv5oDUkmO56FQnV3/keAxy83Nrs+QoGn0VCxwPc852uR01U9zc6ub+zcW4pAlDKzA0tEx0KOYX2k0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JKZZQSjU0p6UFry7079IjXJ/K+Ayr1STBHgsL3rdmkg=;
 b=Kv9bsH6zt/+3mvhD+G0q6FQuUXVKR0wI3J48Q5Ee0SG7OABFZke2Ij8UqURv2K8xA+gSal+pNkyqi4UF6igUkphCiJSNlrm896wBiIhKss/VzlXZl1wmThbCbqjp2ERnTuxAUL5c/XO9+WoCToGIswtKt9y34muZJjluxHow95Q=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
Received: from BN6PR12MB1699.namprd12.prod.outlook.com (10.175.97.148) by
 BN6PR12MB1651.namprd12.prod.outlook.com (10.172.18.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.29; Wed, 5 Feb 2020 14:02:26 +0000
Received: from BN6PR12MB1699.namprd12.prod.outlook.com
 ([fe80::64:3847:8cd3:9e0a]) by BN6PR12MB1699.namprd12.prod.outlook.com
 ([fe80::64:3847:8cd3:9e0a%6]) with mapi id 15.20.2686.035; Wed, 5 Feb 2020
 14:02:26 +0000
Subject: Re: [RFC PATCH] drm/amdgpu: Remove eviction fence before release bo
To: "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <SN6PR12MB28003CCDAC027B461B900FA287020@SN6PR12MB2800.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <1a10335b-6668-7a2f-de0c-ac41488f6b68@amd.com>
Date: Wed, 5 Feb 2020 15:02:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <SN6PR12MB28003CCDAC027B461B900FA287020@SN6PR12MB2800.namprd12.prod.outlook.com>
Content-Language: en-US
X-ClientProxiedBy: ZR0P278CA0022.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1c::9) To BN6PR12MB1699.namprd12.prod.outlook.com
 (2603:10b6:404:ff::20)
MIME-Version: 1.0
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
 (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by
 ZR0P278CA0022.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:1c::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.21 via Frontend Transport; Wed, 5 Feb 2020 14:02:25 +0000
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 70e3c4d9-a68e-4193-679d-08d7aa4407af
X-MS-TrafficTypeDiagnostic: BN6PR12MB1651:|BN6PR12MB1651:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN6PR12MB16512B038C488856B928981383020@BN6PR12MB1651.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 0304E36CA3
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(136003)(39860400002)(376002)(366004)(346002)(189003)(199004)(316002)(31686004)(186003)(36756003)(16526019)(6486002)(478600001)(66476007)(4326008)(2906002)(2616005)(8676002)(81156014)(86362001)(31696002)(6666004)(5660300002)(81166006)(52116002)(110136005)(66946007)(8936002)(66556008)(54906003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BN6PR12MB1651;
 H:BN6PR12MB1699.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1FcTtOmqH3ml+pl5KaxYkw77DEe8u7NqjdDn46jCLm4xCBgRQGc83exBZrKlNzl3omMvh0u2xZyVhcb0607poqVH1P9bOsL2W2opLBgEYBqw7kfuWeA4uE1L3EIzOdNWjymPoUbCihSfxYo+KV2HelPn5U4GnNclZJWRTtXQLQ8gc04rq8zZoh7j0unpg1DItkeijb2Po0d6haicaoDvqMBu+RMLoMhRIuJ6ruTXQ5Hnu2mK0IiFEERC0TQPeql1XeOStyuSah/lj6bWrQ5gJy2AXEYkvscMkHevH6JuwgJ0AEXp2QYUVkSMQ5wKkGdroRAjyvb5gkWmAE6ggD+FziMw01Jh5zYhuTDir31aBrugelvlBmzC/iVUaCyy5UFXi4Nrc5n5eTMB6gXZb7EDon3f0b+ypHmN8vvxWFQr4pgoTXaRNipilz6z8pq3gSgt
X-MS-Exchange-AntiSpam-MessageData: EsxsjoJqsyQbowhCSjUSyJ+qSCAoogVayRN0psy9CaAIznO4FHY0FgZ+PLQRO4lBkLzNT42pk/XzkvApixAXxxasoSC+CH07UZhAMqzi/3VspHJXQITZEZVLaE5xl7W0FsTHTX3PuZHHSkbZF6H2dBsHpsX6KLqAeDkzboP5SFKySIriLv2xiXCOqQgJDbNjh+B9LSXVBVg3HNFgzRsiLA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70e3c4d9-a68e-4193-679d-08d7aa4407af
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2020 14:02:26.1567 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NRbls3AR+WhQzQ+F3hlohCPPp5/0rrILZpc0e4G0MKyV+9U4XduBw7DDVnvGW3Px
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1651
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Kuehling,
 Felix" <Felix.Kuehling@amd.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 05.02.20 um 13:56 schrieb Pan, Xinhui:
> No need to trigger eviction as the memory mapping will not be used anymore.
>
> All pt/pd bos share same resv, hence the same shared eviction fence. Everytime page table is freed, the fence will be signled and that cuases kfd unexcepted evictions.
>
> kfd bo uses its own resv, so it is not affetced.
>
> Signed-off-by: xinhui pan <xinhui.pan@amd.com>
> ---
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> index 47b0f29..265b1ed 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> @@ -96,6 +96,7 @@
>   						       struct mm_struct *mm);
>   bool amdkfd_fence_check_mm(struct dma_fence *f, struct mm_struct *mm);
>   struct amdgpu_amdkfd_fence *to_amdgpu_amdkfd_fence(struct dma_fence *f);
> +int amdgpu_amdkfd_remove_fence_on_pt_pd_bos(struct amdgpu_bo *bo);
>   
>   struct amdkfd_process_info {
>   	/* List head of all VMs that belong to a KFD process */
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index ef721cb..a3c55ad 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -276,6 +276,26 @@
>   	return 0;
>   }
>   
> +int amdgpu_amdkfd_remove_fence_on_pt_pd_bos(struct amdgpu_bo *bo)
> +{
> +	struct amdgpu_vm *vm;
> +	int ret = 0;
> +
> +	if (bo->vm_bo && bo->vm_bo->vm) {
> +		vm = bo->vm_bo->vm;
> +		if (vm->process_info && vm->process_info->eviction_fence) {

Better write that as checking of prerequisites, e.g. if (!...) return;

> +			BUG_ON(!dma_resv_trylock(&bo->tbo.base._resv));
> +			if (bo->tbo.base.resv != &bo->tbo.base._resv) {
> +				dma_resv_copy_fences(&bo->tbo.base._resv, bo->tbo.base.resv);
> +				bo->tbo.base.resv = &bo->tbo.base._resv;

That doesn't work correctly and could crash really really badly. We need 
to rework how deleted BOs are handled in TTM first for this.

Roughly a month or two ago I send out a patch set which does that, but I 
never got around to finish it up.

Regards,
Christian.

> +			}
> +			ret = amdgpu_amdkfd_remove_eviction_fence(bo, vm->process_info->eviction_fence);
> +			dma_resv_unlock(bo->tbo.base.resv);
> +		}
> +	}
> +	return ret;
> +}
> +
>   static int amdgpu_amdkfd_bo_validate(struct amdgpu_bo *bo, uint32_t domain,
>   				     bool wait)
>   {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> index 6f60a58..4b5bee0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> @@ -1307,6 +1307,9 @@
>   	if (abo->kfd_bo)
>   		amdgpu_amdkfd_unreserve_memory_limit(abo);
>   
> +	amdgpu_amdkfd_remove_fence_on_pt_pd_bos(abo);
> +	abo->vm_bo = NULL;
> +
>   	if (bo->mem.mem_type != TTM_PL_VRAM || !bo->mem.mm_node ||
>   	    !(abo->flags & AMDGPU_GEM_CREATE_VRAM_WIPE_ON_RELEASE))
>   		return;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index cc56eab..187cdb3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -945,7 +945,6 @@
>   static void amdgpu_vm_free_table(struct amdgpu_vm_pt *entry)
>   {
>   	if (entry->base.bo) {
> -		entry->base.bo->vm_bo = NULL;
>   		list_del(&entry->base.vm_status);
>   		amdgpu_bo_unref(&entry->base.bo->shadow);
>   		amdgpu_bo_unref(&entry->base.bo);

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
