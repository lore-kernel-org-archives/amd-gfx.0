Return-Path: <SRS0=thZ3=2A=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC4FDC43603
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Dec 2019 10:55:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81AE42073B
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Dec 2019 10:55:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="kLDryF4o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81AE42073B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 45CB96E8B7;
	Tue, 10 Dec 2019 10:55:37 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2041.outbound.protection.outlook.com [40.107.92.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3BE566E8B7
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Dec 2019 10:55:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dn2nP4HbHoLNPvbbr/g8/8BDnnt4c5p3Ovib/SPIgi5ub4Wksst/zfNy1cIK9C1PWR24RTcwaStfstHZDBRvY0f1XUhZTWE9mgfDPJ+WUw4igoFK4AG2Pe/qpltQUik/l1HPZh5PGjAhGLVjg6mLffYTFOjyU6hLUXqTdyW5qHVdCJVE+6hGVHEHdv3u6TC6RbiaaticZIxBjvd7icQkGJVGr9IcEMmJtBTEMb7ICZuZx/EMh4xvr5cK4ev1uX+PVTbDSWGDXXGlieLY0yBJmuG8JWx+2SppzrgjaEWA43IH+7Ybs0u51reKbsz/ErUt+oAzNEryq+XotbyfvLMYWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mx/XpE1aXbWiFeMWGPSxc/QV8w9Xep48UoyMHFNAX3E=;
 b=M7ZkyTXMC1G23u/7xwr69eh13NBjWUu7Bin5PSN8Q6pf3/1VRKIw0zRS8KzUjd3rz58ccOz1+7MxmUgq0gjVUKfaQVk1OomNXrgloBqZme7MHxBBzzldw/aeAXxW7vdqPpy45/5o11cHHH/K/RZYBj/8AYAMSl7V+rWy7LKwpJW18sqBGK735MU8iavs75GlC0K+MH9s+GJnwlhtN4c8EIWERxO5UeSSq2lUb+zihPlOp683tWVpKAfTPetAIborM27qNCMf8qhCOG+ZYgiXr32nZBDkEHYXqayOCYZCnRKoSKEEUu+RHl+e2SEyiTSgZwOP6M8QK4LTfL/QVbvM3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mx/XpE1aXbWiFeMWGPSxc/QV8w9Xep48UoyMHFNAX3E=;
 b=kLDryF4olvZa4kwf92vSCOW5kMOAfophyjBzbSR2lRX5m6xS8gb3wGWTza4G0j8mF19P0vuulbN9Qc6hlfrBYjrv4ucVjxQUIs/unhZZkxDyO7L65XDYISDXBFJegUWDCwvyLauvBXQSwiXo5gwqUUQLtlFcm4dZBzdeNA0TFN8=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
Received: from DM5PR12MB1705.namprd12.prod.outlook.com (10.175.88.22) by
 DM5PR12MB1356.namprd12.prod.outlook.com (10.168.237.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.17; Tue, 10 Dec 2019 10:55:34 +0000
Received: from DM5PR12MB1705.namprd12.prod.outlook.com
 ([fe80::80df:f8b:e547:df84]) by DM5PR12MB1705.namprd12.prod.outlook.com
 ([fe80::80df:f8b:e547:df84%12]) with mapi id 15.20.2516.018; Tue, 10 Dec 2019
 10:55:34 +0000
Subject: Re: [PATCH] drm/amdgpu: avoid using invalidate semaphore for
 picasso(v2)
To: "Changfeng.Zhu" <changfeng.zhu@amd.com>, amd-gfx@lists.freedesktop.org,
 Ray.Huang@amd.com, Xinmei.Huang@amd.com, Alexander.Deucher@amd.com
References: <20191210025513.14625-1-changfeng.zhu@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <87718283-3287-819e-ee9f-a3d57112bc5d@amd.com>
Date: Tue, 10 Dec 2019 11:55:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <20191210025513.14625-1-changfeng.zhu@amd.com>
Content-Language: en-US
X-ClientProxiedBy: AM0PR01CA0056.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:e6::33) To DM5PR12MB1705.namprd12.prod.outlook.com
 (2603:10b6:3:10c::22)
MIME-Version: 1.0
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3d773201-e8ef-4939-adaf-08d77d5f7b8b
X-MS-TrafficTypeDiagnostic: DM5PR12MB1356:|DM5PR12MB1356:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1356ADB5D5D830C664E74349835B0@DM5PR12MB1356.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 02475B2A01
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(376002)(136003)(39860400002)(346002)(396003)(199004)(189003)(52116002)(2616005)(36756003)(81166006)(6506007)(316002)(31696002)(186003)(31686004)(6512007)(478600001)(66946007)(8936002)(6636002)(86362001)(66476007)(8676002)(6486002)(66556008)(2906002)(81156014)(6666004)(5660300002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1356;
 H:DM5PR12MB1705.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PK86xw+jK3gcY9tIi+uUXoTqe8gPjUskiRr9mxUVAh8iE+HF8zg/nVeBwG7LSa5TSboNfykDQZ4/ztb2kcJapQWtKIQp+NoZMb5zQWcDHCdftM/6RxLxPIQLJkgo9FeGcJ1x5LxH5VGU/xt/UcgMwpWde7tSSZaAgpZLDNXeKL360krXdB+vNSsO77ZfZqbq9rMiNNdZzGqbr+9uvuUBSiDZSP70h8nEoSR7co+YYo6PmHcGZ65btq23AxXXLJN+0gGtGR/wR3tAFA7n31HtCH/vXzHSByDY+qstN+Z0EEMFZ320Swhat66vD0Ic165IOrc3NXOzfkA16S1UYw9Y8d55/FqRTzIKdT8+bz3OZ0iaxrkq6mS+f4FalCt0rvuomm5U2xZ+tacv+Y34Oh2y1RSoQGN+P2nuUZzJmLLx43kcCDriiSX6pebb7bvkkShF
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d773201-e8ef-4939-adaf-08d77d5f7b8b
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2019 10:55:34.5730 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FxQc0+P9hbi/gSTKmYjhMyRSs66vSYetF4XIXPwbS+EUMuDE0p3shL937zvc3VFG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1356
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 10.12.19 um 03:55 schrieb Changfeng.Zhu:
> From: changzhu <Changfeng.Zhu@amd.com>
>
> It may cause timeout waiting for sem acquire in VM flush when using
> invalidate semaphore for picasso. So it needs to avoid using invalidate
> semaphore for piasso.

It would probably be better to add a small helper function to decide if 
the semaphore registers should be used or not.

E.g. something like "bool gmc_v9_0_use_semaphore(adev, vmhub...)"

Apart from that looks good to me,
Christian.

>
> Change-Id: I6dc552bde180919cd5ba6c81c6d9e3f800043b03
> Signed-off-by: changzhu <Changfeng.Zhu@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 28 +++++++++++++++++++--------
>   1 file changed, 20 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> index 231ea9762cb5..601667246a1c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> @@ -464,8 +464,11 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
>   	 */
>   
>   	/* TODO: It needs to continue working on debugging with semaphore for GFXHUB as well. */
> -	if (vmhub == AMDGPU_MMHUB_0 ||
> -	    vmhub == AMDGPU_MMHUB_1) {
> +	if ((vmhub == AMDGPU_MMHUB_0 ||
> +	     vmhub == AMDGPU_MMHUB_1) &&
> +	    (!(adev->asic_type == CHIP_RAVEN &&
> +	       adev->rev_id < 0x8 &&
> +	       adev->pdev->device == 0x15d8))) {
>   		for (j = 0; j < adev->usec_timeout; j++) {
>   			/* a read return value of 1 means semaphore acuqire */
>   			tmp = RREG32_NO_KIQ(hub->vm_inv_eng0_sem + eng);
> @@ -495,8 +498,11 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
>   	}
>   
>   	/* TODO: It needs to continue working on debugging with semaphore for GFXHUB as well. */
> -	if (vmhub == AMDGPU_MMHUB_0 ||
> -	    vmhub == AMDGPU_MMHUB_1)
> +	if ((vmhub == AMDGPU_MMHUB_0 ||
> +	     vmhub == AMDGPU_MMHUB_1) &&
> +	    (!(adev->asic_type == CHIP_RAVEN &&
> +	       adev->rev_id < 0x8 &&
> +	       adev->pdev->device == 0x15d8)))
>   		/*
>   		 * add semaphore release after invalidation,
>   		 * write with 0 means semaphore release
> @@ -527,8 +533,11 @@ static uint64_t gmc_v9_0_emit_flush_gpu_tlb(struct amdgpu_ring *ring,
>   	 */
>   
>   	/* TODO: It needs to continue working on debugging with semaphore for GFXHUB as well. */
> -	if (ring->funcs->vmhub == AMDGPU_MMHUB_0 ||
> -	    ring->funcs->vmhub == AMDGPU_MMHUB_1)
> +	if ((ring->funcs->vmhub == AMDGPU_MMHUB_0 ||
> +	     ring->funcs->vmhub == AMDGPU_MMHUB_1) &&
> +	    (!(adev->asic_type == CHIP_RAVEN &&
> +	       adev->rev_id < 0x8 &&
> +	       adev->pdev->device == 0x15d8)))
>   		/* a read return value of 1 means semaphore acuqire */
>   		amdgpu_ring_emit_reg_wait(ring,
>   					  hub->vm_inv_eng0_sem + eng, 0x1, 0x1);
> @@ -544,8 +553,11 @@ static uint64_t gmc_v9_0_emit_flush_gpu_tlb(struct amdgpu_ring *ring,
>   					    req, 1 << vmid);
>   
>   	/* TODO: It needs to continue working on debugging with semaphore for GFXHUB as well. */
> -	if (ring->funcs->vmhub == AMDGPU_MMHUB_0 ||
> -	    ring->funcs->vmhub == AMDGPU_MMHUB_1)
> +	if ((ring->funcs->vmhub == AMDGPU_MMHUB_0 ||
> +	     ring->funcs->vmhub == AMDGPU_MMHUB_1) &&
> +	    (!(adev->asic_type == CHIP_RAVEN &&
> +	       adev->rev_id < 0x8 &&
> +	       adev->pdev->device == 0x15d8)))
>   		/*
>   		 * add semaphore release after invalidation,
>   		 * write with 0 means semaphore release

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
