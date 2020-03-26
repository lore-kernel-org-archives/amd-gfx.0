Return-Path: <SRS0=17Cd=5L=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15C99C43331
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Mar 2020 11:02:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A836720409
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Mar 2020 11:02:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="A9Dg+X5h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A836720409
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 51F8889242;
	Thu, 26 Mar 2020 11:02:48 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2089.outbound.protection.outlook.com [40.107.236.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B5E5689242
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Mar 2020 11:02:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V3BUs0/dReRyre0bAWjdbMcAETzVZIHdPXT6mNxJkYFJhWaSy2CG1z1jbvvdbqIYk3PAZv4WChLqe0JN4Tc4kaxHDdrEtmvI3A5tslcbkC5BRWMJqQceNtAhuKLoHBrdPMVzZFle3WhX9UbX3lFrPy+0ottj+DVjNo9emOkTH0iJCF+dVhkrMPpnqsrqdCgoLshrZ7ymolDWxEkDz+4aYIySsrZ4gx2dR15SzGeLiiMAkpMG3q31eAephwPP5bhKe5NZfUxB4jxO36rvTJxEbdgpBCPeC7BgtTbfcAtjNR9cqBYLUijuKM+TyZkAIBExwdoMAFreUdI1Re5+MssCEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4N2/EbHRsYwyp8oiBZHyZNQwCwI8LFyy1VlOMxws3fw=;
 b=n4cic6ecowtMQbOKl5/R2Q1uIfwGF3rbZ7MpZwGm4lC9V9WcB8wEFRtVjBg4qsecCWnK5m52tEiglwKfWi85ylYwGDN9pSEsEIYptDwV4R8xFlFETvQAydkO1e/BZncFn/KVbFgS6DLYOvxCnmbHck6Z5n7FQSpVR5NvQd+H1KuvyYZ/t3lFp6E5NTkFI1hL9nHxjPjdJepWbevIia+mSw7Yf/NHx6b+unOUkamyY0sfQsYW27YkOzmQF892WhNii352naP/qx+aU6h1quMUtT5x/v/iAEmpceAH6Z9HZbvFJQZt8yt4MN5VBJs6xOjiUv6hih9G5Vg7JGqggYAFOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4N2/EbHRsYwyp8oiBZHyZNQwCwI8LFyy1VlOMxws3fw=;
 b=A9Dg+X5hbS6A1PdIURZAzsfVxw4VOHyytairvTJEnXfT3BF+UFWn7/DdLpnH/U6GGRWDTX/qX3Dg3MWYisdYrWgxwPKwDqDF0qC22Z29+KhiQgIgmR6Py5XJdl8R/qZZtr2ZX4wa4qoxgKkkA1UUkFERxHbnCib7kUS4lmKvgxI=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
Received: from DM6PR12MB4401.namprd12.prod.outlook.com (2603:10b6:5:2a9::15)
 by DM6PR12MB3676.namprd12.prod.outlook.com (2603:10b6:5:1c7::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.22; Thu, 26 Mar
 2020 11:02:46 +0000
Received: from DM6PR12MB4401.namprd12.prod.outlook.com
 ([fe80::f164:85c4:1b51:14d2]) by DM6PR12MB4401.namprd12.prod.outlook.com
 ([fe80::f164:85c4:1b51:14d2%4]) with mapi id 15.20.2856.019; Thu, 26 Mar 2020
 11:02:45 +0000
Subject: Re: [RFC PATCH 1/2] drm/amdgpu: implement more ib pools
To: xinhui pan <xinhui.pan@amd.com>, amd-gfx@lists.freedesktop.org
References: <20200326094708.4253-1-xinhui.pan@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <7451ee03-3299-154b-f8f7-44de05d7f65a@amd.com>
Date: Thu, 26 Mar 2020 12:02:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <20200326094708.4253-1-xinhui.pan@amd.com>
Content-Language: en-US
X-ClientProxiedBy: ZR0P278CA0034.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1c::21) To DM6PR12MB4401.namprd12.prod.outlook.com
 (2603:10b6:5:2a9::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
 (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by
 ZR0P278CA0034.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:1c::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2856.19 via Frontend Transport; Thu, 26 Mar 2020 11:02:44 +0000
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 4e5791f1-41d6-4a3c-7132-08d7d17536be
X-MS-TrafficTypeDiagnostic: DM6PR12MB3676:|DM6PR12MB3676:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB367633AF5334617E986BEB0683CF0@DM6PR12MB3676.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1468;
X-Forefront-PRVS: 0354B4BED2
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(136003)(366004)(346002)(376002)(396003)(31696002)(86362001)(52116002)(8936002)(6666004)(81156014)(81166006)(316002)(2906002)(6486002)(8676002)(186003)(66556008)(66946007)(16526019)(5660300002)(2616005)(36756003)(4326008)(478600001)(66476007)(31686004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB3676;
 H:DM6PR12MB4401.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ehfMsNnE6p8t/sjFusgO6pfeNAjlo9CyzrN2jdJpacreajwsyaRqUFuxIF5fPKoUJWU18X618/PsClTybUfVi/lelTDHKr+zNxpDu7du9FIU5nuzQEQqiQyMYK5wYJqvUl/RujOe22McqN+P2K/lht5GCGwKbEXs8Q+H2znRTBX4m2CQtTLASOhd/9nazaXkAI394xLWbDQoK2D9Au9Kfeks3/n34OQUkGVV7xLSI36UrWiUrzgUtpJ5m/KGGjbAh0fN+mJuNtAodU8FRBe7c53wznGnN9IgToLbRtJDi09OFYXE1TfINyfwvmUe2U0eHmRiFtbjgFsvsk/DbI6YXNlQUVaXMhegausP68YmJy8qJMCAcS5+tl9j+gpjohPtMeAZ9rxa938f1W3DWyHXny8I9U/++fn3DBpMIph1mR97wWdxdy3CHUo4GjQH6JW/
X-MS-Exchange-AntiSpam-MessageData: 5dvRN0O/Dk/THBkBYcnmJys0w4viz+jBnqVe2EDRlWdsFcAoSNFDx35W0/dy1W5tnQ4+Q2W3T3AMiuc4ngikVXqXvraruSYW3vkL+ZpbgdPCr2TRhIIySqjnzBdSKTL8Z/z4GXgm9eJ/zjbFBb+Lv9TkqSwyf57PoKvJm4SN+9LLpdTBfRrRDrKiso7i7pq3l8txdL988g0LzdvO5xWaBQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e5791f1-41d6-4a3c-7132-08d7d17536be
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2020 11:02:45.8851 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PBojBXqoaTX93w7cL0NRXuuoaegFjvLzhnwEvGwIbJ+ccyiHvjU0behOVSGrynyh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3676
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
Cc: alexander.deucher@amd.com, Felix.Kuehling@amd.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 26.03.20 um 10:47 schrieb xinhui pan:
> We have tree ib pools, they are normal, VM, direct pools.
>
> Any jobs which schedule IBs without dependence on gpu scheduler should
> use DIRECT pool.
>
> Any jobs schedule direct VM update IBs should use VM pool.
>
> Any other jobs use NORMAL pool.
>
> Signed-off-by: xinhui pan <xinhui.pan@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h     | 11 ++++++-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c  |  4 +--
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c  | 41 ++++++++++++++++++-------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_job.c |  8 ++++-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_job.h |  4 ++-
>   5 files changed, 52 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 7dd74253e7b6..3d70c113c205 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -390,6 +390,13 @@ struct amdgpu_sa_bo {
>   int amdgpu_fence_slab_init(void);
>   void amdgpu_fence_slab_fini(void);
>   
> +enum amd_ib_pool_type {
> +	AMD_IB_POOL_NORMAL = 0,
> +	AMD_IB_POOL_VM,
> +	AMD_IB_POOL_DIRECT,
> +
> +	AMD_MAX_IB_POOL
> +};

Please use the prefix amdgpu_ib_pool_* here.

>   /*
>    * IRQS.
>    */
> @@ -442,6 +449,8 @@ int amdgpu_file_to_fpriv(struct file *filp, struct amdgpu_fpriv **fpriv);
>   
>   int amdgpu_ib_get(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   		  unsigned size, struct amdgpu_ib *ib);
> +int amdgpu_ib_get_with_pool(struct amdgpu_device *adev, struct amdgpu_vm *vm,
> +		  unsigned size, struct amdgpu_ib *ib, enum amd_ib_pool_type pool);

Don't add a new function, just change the existing amdgpu_ib_get() and 
all its callers.

>   void amdgpu_ib_free(struct amdgpu_device *adev, struct amdgpu_ib *ib,
>   		    struct dma_fence *f);
>   int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned num_ibs,
> @@ -848,7 +857,7 @@ struct amdgpu_device {
>   	unsigned			num_rings;
>   	struct amdgpu_ring		*rings[AMDGPU_MAX_RINGS];
>   	bool				ib_pool_ready;
> -	struct amdgpu_sa_manager	ring_tmp_bo;
> +	struct amdgpu_sa_manager	ring_tmp_bo[AMD_MAX_IB_POOL];
>   
>   	/* interrupts */
>   	struct amdgpu_irq		irq;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> index 59ec5e2be211..182c7ee439cc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> @@ -920,8 +920,8 @@ static int amdgpu_cs_ib_fill(struct amdgpu_device *adev,
>   		parser->entity = entity;
>   
>   		ring = to_amdgpu_ring(entity->rq->sched);
> -		r =  amdgpu_ib_get(adev, vm, ring->funcs->parse_cs ?
> -				   chunk_ib->ib_bytes : 0, ib);
> +		r =  amdgpu_ib_get_with_pool(adev, vm, ring->funcs->parse_cs ?
> +				   chunk_ib->ib_bytes : 0, ib, AMD_IB_POOL_NORMAL);
>   		if (r) {
>   			DRM_ERROR("Failed to get ib !\n");
>   			return r;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> index bece01f1cf09..460b50a5f875 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> @@ -62,11 +62,17 @@
>    */
>   int amdgpu_ib_get(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   		  unsigned size, struct amdgpu_ib *ib)
> +{
> +	return amdgpu_ib_get_with_pool(adev, vm, size, ib, AMD_IB_POOL_DIRECT);
> +}
> +
> +int amdgpu_ib_get_with_pool(struct amdgpu_device *adev, struct amdgpu_vm *vm,
> +		  unsigned size, struct amdgpu_ib *ib, enum amd_ib_pool_type pool_type)
>   {
>   	int r;
>   
>   	if (size) {
> -		r = amdgpu_sa_bo_new(&adev->ring_tmp_bo,
> +		r = amdgpu_sa_bo_new(&adev->ring_tmp_bo[pool_type],
>   				      &ib->sa_bo, size, 256);
>   		if (r) {
>   			dev_err(adev->dev, "failed to get a new IB (%d)\n", r);
> @@ -297,19 +303,27 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned num_ibs,
>    */
>   int amdgpu_ib_pool_init(struct amdgpu_device *adev)
>   {
> -	int r;
> +	int r, i;
> +	unsigned size;
>   
>   	if (adev->ib_pool_ready) {
>   		return 0;
>   	}
> -	r = amdgpu_sa_bo_manager_init(adev, &adev->ring_tmp_bo,
> -				      AMDGPU_IB_POOL_SIZE*64*1024,
> -				      AMDGPU_GPU_PAGE_SIZE,
> -				      AMDGPU_GEM_DOMAIN_GTT);
> -	if (r) {
> -		return r;
> +	for (i = 0; i < AMD_MAX_IB_POOL; i++) {
> +		if (i == AMD_IB_POOL_DIRECT)
> +			size = PAGE_SIZE * 2;
> +		else
> +			size = AMDGPU_IB_POOL_SIZE*64*1024;
> +		r = amdgpu_sa_bo_manager_init(adev, &adev->ring_tmp_bo[i],
> +				size,
> +				AMDGPU_GPU_PAGE_SIZE,
> +				AMDGPU_GEM_DOMAIN_GTT);
> +		if (r) {
> +			for (i--; i >= 0; i--)
> +				amdgpu_sa_bo_manager_fini(adev, &adev->ring_tmp_bo[i]);
> +			return r;
> +		}
>   	}
> -
>   	adev->ib_pool_ready = true;
>   
>   	return 0;
> @@ -325,8 +339,11 @@ int amdgpu_ib_pool_init(struct amdgpu_device *adev)
>    */
>   void amdgpu_ib_pool_fini(struct amdgpu_device *adev)
>   {
> +	int i;
> +
>   	if (adev->ib_pool_ready) {
> -		amdgpu_sa_bo_manager_fini(adev, &adev->ring_tmp_bo);
> +		for (i = 0; i < AMD_MAX_IB_POOL; i++)
> +			amdgpu_sa_bo_manager_fini(adev, &adev->ring_tmp_bo[i]);
>   		adev->ib_pool_ready = false;
>   	}
>   }
> @@ -423,7 +440,9 @@ static int amdgpu_debugfs_sa_info(struct seq_file *m, void *data)
>   	struct drm_device *dev = node->minor->dev;
>   	struct amdgpu_device *adev = dev->dev_private;
>   
> -	amdgpu_sa_bo_dump_debug_info(&adev->ring_tmp_bo, m);
> +	amdgpu_sa_bo_dump_debug_info(&adev->ring_tmp_bo[AMD_IB_POOL_NORMAL], m);
> +	amdgpu_sa_bo_dump_debug_info(&adev->ring_tmp_bo[AMD_IB_POOL_VM], m);
> +	amdgpu_sa_bo_dump_debug_info(&adev->ring_tmp_bo[AMD_IB_POOL_DIRECT], m);

Maybe add something like seq_printf(m, "-------------------- name of 
pool ----------------"); between each call.

>   
>   	return 0;
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> index 4981e443a884..2e98ce568a3f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> @@ -88,6 +88,12 @@ int amdgpu_job_alloc(struct amdgpu_device *adev, unsigned num_ibs,
>   
>   int amdgpu_job_alloc_with_ib(struct amdgpu_device *adev, unsigned size,
>   			     struct amdgpu_job **job)
> +{
> +	return amdgpu_job_alloc_with_ib_pool(adev, size, job, AMD_IB_POOL_NORMAL);
> +}
> +
> +int amdgpu_job_alloc_with_ib_pool(struct amdgpu_device *adev, unsigned size,
> +			     struct amdgpu_job **job, enum amd_ib_pool_type pool_type)
>   {
>   	int r;
>   
> @@ -95,7 +101,7 @@ int amdgpu_job_alloc_with_ib(struct amdgpu_device *adev, unsigned size,
>   	if (r)
>   		return r;
>   
> -	r = amdgpu_ib_get(adev, NULL, size, &(*job)->ibs[0]);
> +	r = amdgpu_ib_get_with_pool(adev, NULL, size, &(*job)->ibs[0], pool_type);
>   	if (r)
>   		kfree(*job);
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
> index 2e2110dddb76..c34516bf9278 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
> @@ -38,6 +38,7 @@
>   #define AMDGPU_JOB_GET_VMID(job) ((job) ? (job)->vmid : 0)
>   
>   struct amdgpu_fence;
> +enum amd_ib_pool_type;
>   
>   struct amdgpu_job {
>   	struct drm_sched_job    base;
> @@ -67,7 +68,8 @@ int amdgpu_job_alloc(struct amdgpu_device *adev, unsigned num_ibs,
>   		     struct amdgpu_job **job, struct amdgpu_vm *vm);
>   int amdgpu_job_alloc_with_ib(struct amdgpu_device *adev, unsigned size,
>   			     struct amdgpu_job **job);
> -
> +int amdgpu_job_alloc_with_ib_pool(struct amdgpu_device *adev, unsigned size,
> +			     struct amdgpu_job **job, enum amd_ib_pool_type pool);

Again just add the new parameter to amdgpu_job_alloc_with_ib() instead 
of adding a new function.

Apart from that looks good to me,
Christian.

>   void amdgpu_job_free_resources(struct amdgpu_job *job);
>   void amdgpu_job_free(struct amdgpu_job *job);
>   int amdgpu_job_submit(struct amdgpu_job *job, struct drm_sched_entity *entity,

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
