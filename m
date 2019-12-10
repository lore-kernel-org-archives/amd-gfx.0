Return-Path: <SRS0=thZ3=2A=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98D9AC43603
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Dec 2019 03:10:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60A1120726
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Dec 2019 03:10:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="UPr0HJwY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60A1120726
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 107296E7D1;
	Tue, 10 Dec 2019 03:10:35 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2080.outbound.protection.outlook.com [40.107.237.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AD1856E7D1
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Dec 2019 03:10:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aSYW4/esPv/abwsi0zUCg+uld4mQrLsatT5QH6E+sYro1Ngl11SqrN4jRSr/1onPQ95+ddlKt5VgTDyKxhm8+EFahaUhaABjP9tQgkCHpw9rZ/VAlSgLaM4azmPtXZbTM5gHXwaVfRv60C1SPhLPPAJlczXN6dE+vLUSHyErZDnFbewodsqGRhxjzWs/oN7wUoqannaV7Y/sj49M3On71LcCJQpzpVuEOQ2GzDeNhMekR/DBvTChQKGfJ3LIx1td+Ckb3j6SsAFG/8tokwZDWoqxPD1OCpVyFXtxn0Gd4jrqKUF/GA2JBIoKpWtAPM8S2hjUNMhn3eweRU/3yDTftg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RzixUcqILR2H2TDJg1/EjIDXIsFbCRuXyjGPtSW+wpc=;
 b=gFTUVD/ujr4ync60IeZlWRCsM8VmAlzA6aqQ50/oa9DaCK2Wkc/RI2dn0uahjbPYzwxAo85fDvtGU6/fSo4nqHAUP1QZOY5OuBgubkttGXSdQb/tbJ5dU1kjdBZYVatlTPXRa2NIKemUGzfihTxmYur48X2mjyohZmWjL+6y8AsgCgjlHJvJxU3v/86Zok1XbtfDb3bUIphC9v54a6mzJQiJPUlhERVxh7qxzB2TbpDfY7yfQCuC7j4fVaEkzE8G9iVbRJgEegksQBHPl90FAhtH85wLbqNQNQM5AwbaznyaxagjifRqmTfegtPguEU6RUHtOmTZ0dogF22WwvgmbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RzixUcqILR2H2TDJg1/EjIDXIsFbCRuXyjGPtSW+wpc=;
 b=UPr0HJwY+cKVCSJfggg8Fw40OIgwJPd8ypHk1tKFPskh41PGegw2nh3IX5CUS76uzedrOk7rzcwnBdEjTtDn1eoDt5JKgLbJk94TufndSHieB5ZiL0dIx1t6tW/jipTtn3vxIAh0ZDPUu4WedrrctA4hIPRW6M6jNIgkVJao69M=
Received: from MN2PR12MB3309.namprd12.prod.outlook.com (20.179.83.157) by
 MN2PR12MB3871.namprd12.prod.outlook.com (10.255.238.81) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.12; Tue, 10 Dec 2019 03:10:31 +0000
Received: from MN2PR12MB3309.namprd12.prod.outlook.com
 ([fe80::18c4:9fcb:3813:14f7]) by MN2PR12MB3309.namprd12.prod.outlook.com
 ([fe80::18c4:9fcb:3813:14f7%6]) with mapi id 15.20.2516.018; Tue, 10 Dec 2019
 03:10:31 +0000
From: "Huang, Ray" <Ray.Huang@amd.com>
To: "Zhu, Changfeng" <Changfeng.Zhu@amd.com>
Subject: Re: [PATCH] drm/amdgpu: avoid using invalidate semaphore for
 picasso(v2)
Thread-Topic: [PATCH] drm/amdgpu: avoid using invalidate semaphore for
 picasso(v2)
Thread-Index: AQHVrwVMWSX+xX1roUiR/NPFxEcDs6ezNo+A
Date: Tue, 10 Dec 2019 03:10:31 +0000
Message-ID: <MN2PR12MB330996B89182A06501E9905AEC5B0@MN2PR12MB3309.namprd12.prod.outlook.com>
References: <20191210025513.14625-1-changfeng.zhu@amd.com>
In-Reply-To: <20191210025513.14625-1-changfeng.zhu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-imapappendstamp: MN2PR12MB3309.namprd12.prod.outlook.com
 (15.20.2516.000)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Ray.Huang@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 43f8d120-6d21-46f5-bfc2-08d77d1e8445
x-ms-traffictypediagnostic: MN2PR12MB3871:|MN2PR12MB3871:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB3871198EE94BE4A571BB26ECEC5B0@MN2PR12MB3871.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3173;
x-forefront-prvs: 02475B2A01
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(39860400002)(376002)(346002)(396003)(366004)(189003)(199004)(66446008)(66946007)(66476007)(81156014)(8676002)(76116006)(186003)(6506007)(229853002)(66556008)(71200400001)(7696005)(478600001)(64756008)(26005)(86362001)(5660300002)(54906003)(316002)(6862004)(6636002)(55016002)(9686003)(8936002)(305945005)(71190400001)(2906002)(4326008)(52536014)(81166006)(33656002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3871;
 H:MN2PR12MB3309.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YK3p6e8wTdw0Iajy4/aJr4CdfcC8Gqx+ysHpnZMUnCsWkGwr5U5FCExhXP0w9PzpSXL0MUzT6HGln6bHov4ytClbSkfBEClas1zuGh5R+Njqf6VcBIQQFy/VXO4HQM1JP0+BUGvX8Rjusl/td7nVYuqDzLF4FQJyClvaLXFzi1rrJH9p/Kf4JoUNPzgMxpTqAGp57CxMGnosb7Q1I5pC7PS0BjNbwSBv2RYKfWmhPkm5/HRVPviVdehd8oWRnjf5lW1ZJ+Vj3kXBhEQ7gJAG0wFEt8QrvUca+loXzfMr4v7hIXori9KASy3JxoNo4YzlcXHnl+cA55cyRS230hzMUYH4miIUCL4mxpp5uVa00xr8ZFHrmWSGZeeDcggmSfJ2mDTqfVxL0AHgyQGqh9y4Il88ZZgkLN8Mvclh45IXkq+sGXdjrZt3IO8xkLtYQSdz
Content-ID: <26D9DFE4E100F14AB3CF18876FBCC5CF@amdcloud.onmicrosoft.com>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43f8d120-6d21-46f5-bfc2-08d77d1e8445
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2019 03:10:31.6689 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MlcW6YVUiWUh1PTl5NeBVjhWrN7NitaV6J02iYEaY+1FKjl5u1uTn03tk/9cTHByCaVz+fTmzMJyQ5FZrfd0Eg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3871
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Huang,
 Shimmer" <Xinmei.Huang@amd.com>, "Koenig, 
 Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Dec 10, 2019 at 10:55:13AM +0800, Zhu, Changfeng wrote:
> From: changzhu <Changfeng.Zhu@amd.com>
> 
> It may cause timeout waiting for sem acquire in VM flush when using
> invalidate semaphore for picasso. So it needs to avoid using invalidate
> semaphore for piasso.
> 
> Change-Id: I6dc552bde180919cd5ba6c81c6d9e3f800043b03
> Signed-off-by: changzhu <Changfeng.Zhu@amd.com>

Reviewed-by: Huang Rui <ray.huang@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 28 +++++++++++++++++++--------
>  1 file changed, 20 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> index 231ea9762cb5..601667246a1c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> @@ -464,8 +464,11 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
>  	 */
>  
>  	/* TODO: It needs to continue working on debugging with semaphore for GFXHUB as well. */
> -	if (vmhub == AMDGPU_MMHUB_0 ||
> -	    vmhub == AMDGPU_MMHUB_1) {
> +	if ((vmhub == AMDGPU_MMHUB_0 ||
> +	     vmhub == AMDGPU_MMHUB_1) &&
> +	    (!(adev->asic_type == CHIP_RAVEN &&
> +	       adev->rev_id < 0x8 &&
> +	       adev->pdev->device == 0x15d8))) {
>  		for (j = 0; j < adev->usec_timeout; j++) {
>  			/* a read return value of 1 means semaphore acuqire */
>  			tmp = RREG32_NO_KIQ(hub->vm_inv_eng0_sem + eng);
> @@ -495,8 +498,11 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
>  	}
>  
>  	/* TODO: It needs to continue working on debugging with semaphore for GFXHUB as well. */
> -	if (vmhub == AMDGPU_MMHUB_0 ||
> -	    vmhub == AMDGPU_MMHUB_1)
> +	if ((vmhub == AMDGPU_MMHUB_0 ||
> +	     vmhub == AMDGPU_MMHUB_1) &&
> +	    (!(adev->asic_type == CHIP_RAVEN &&
> +	       adev->rev_id < 0x8 &&
> +	       adev->pdev->device == 0x15d8)))
>  		/*
>  		 * add semaphore release after invalidation,
>  		 * write with 0 means semaphore release
> @@ -527,8 +533,11 @@ static uint64_t gmc_v9_0_emit_flush_gpu_tlb(struct amdgpu_ring *ring,
>  	 */
>  
>  	/* TODO: It needs to continue working on debugging with semaphore for GFXHUB as well. */
> -	if (ring->funcs->vmhub == AMDGPU_MMHUB_0 ||
> -	    ring->funcs->vmhub == AMDGPU_MMHUB_1)
> +	if ((ring->funcs->vmhub == AMDGPU_MMHUB_0 ||
> +	     ring->funcs->vmhub == AMDGPU_MMHUB_1) &&
> +	    (!(adev->asic_type == CHIP_RAVEN &&
> +	       adev->rev_id < 0x8 &&
> +	       adev->pdev->device == 0x15d8)))
>  		/* a read return value of 1 means semaphore acuqire */
>  		amdgpu_ring_emit_reg_wait(ring,
>  					  hub->vm_inv_eng0_sem + eng, 0x1, 0x1);
> @@ -544,8 +553,11 @@ static uint64_t gmc_v9_0_emit_flush_gpu_tlb(struct amdgpu_ring *ring,
>  					    req, 1 << vmid);
>  
>  	/* TODO: It needs to continue working on debugging with semaphore for GFXHUB as well. */
> -	if (ring->funcs->vmhub == AMDGPU_MMHUB_0 ||
> -	    ring->funcs->vmhub == AMDGPU_MMHUB_1)
> +	if ((ring->funcs->vmhub == AMDGPU_MMHUB_0 ||
> +	     ring->funcs->vmhub == AMDGPU_MMHUB_1) &&
> +	    (!(adev->asic_type == CHIP_RAVEN &&
> +	       adev->rev_id < 0x8 &&
> +	       adev->pdev->device == 0x15d8)))
>  		/*
>  		 * add semaphore release after invalidation,
>  		 * write with 0 means semaphore release
> -- 
> 2.17.1
> 
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
