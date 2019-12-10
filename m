Return-Path: <SRS0=thZ3=2A=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C579DC43603
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Dec 2019 11:03:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92DBB20663
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Dec 2019 11:03:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="0L2ZGmnq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92DBB20663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 564BE6E8BA;
	Tue, 10 Dec 2019 11:03:50 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690041.outbound.protection.outlook.com [40.107.69.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5F1866E8BA
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Dec 2019 11:03:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MuMiB8C31Tawlx0UMqMNW6Uco5xo2XROy149tnUrLFUORSfGUSnrWUH1cuJ/e3FUPbKDJKAhe4BsBfwwBGQPewsTMF+Y+c0vl+bB8ww9tKLUogLMGGbaJL6zfPeu2Sza1BUAzsDqzhDuUZl1RdDaN3KEBlKUg3IbnGlptFMex6hRQgVLXMHHPc4wagrlwm0y3BBtgvvVUVazpsepl141jedqvh3m8+eqMcalk5L17XhyJrDjUGFQ3xt8l4pcSAfcFbbKQboBb3MNeV7MUFZavEAGxv6/45gXXOwr2QSejbeJflasXSbpnA36/lJ36NvpuXpaArikr0Z7lE8t67BHgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6PjtfFTxHy0AqkvujfYnhS95edCopIFOjMpTrfGG0tY=;
 b=PzDcmsdjc3eWj4VQ8NamJeH4wmJYMhhn71KMs8yOfhQjlwOVR1kZnnV3EG6rQbcX5sbImtgQX21BMZM/UMTS11ba5jRM1F72Pg+T5ZVgcPZdMdPuJRXRGPW/tdbGSNWIChef84x8L5Sp67SiXprfsNDC9nFL3yzqq5wuOalzuUQTs8Sxu4SHAeuB6FS/nu9XiV2JrxgLU1+7blkl/i4YH6CsNOzpoXvBhwRt8cBZNxTpv7Uj0oeVb0/i6Pc4U75e2zDC0AbJrwS85mAlY11mUFQH31SRfswvOkxVqeYmBuKz/6mLHI15TDnTjl2Rpi2SqJBN4ToJosgOoACGhlfrgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6PjtfFTxHy0AqkvujfYnhS95edCopIFOjMpTrfGG0tY=;
 b=0L2ZGmnqG0XJu4ivHcFJ4vMvJJt6DSCteeD2CTMmcl2eejN00YFHVk87h/yCozPOrpgcZ9//kqiy5kUzhddQ6oCnfi2pZ9Rn8QZcQ1Kh7UgYK4nmHeeUL6mE9ZbIzV7Tlrfvz2MLBnJnK9nZIdaSUhp7OqvfOiMrUIHGgbupWmA=
Received: from MN2PR12MB2896.namprd12.prod.outlook.com (20.179.80.214) by
 MN2PR12MB3165.namprd12.prod.outlook.com (20.179.81.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.17; Tue, 10 Dec 2019 11:03:44 +0000
Received: from MN2PR12MB2896.namprd12.prod.outlook.com
 ([fe80::9821:4373:684f:f580]) by MN2PR12MB2896.namprd12.prod.outlook.com
 ([fe80::9821:4373:684f:f580%6]) with mapi id 15.20.2516.018; Tue, 10 Dec 2019
 11:03:44 +0000
From: "Zhu, Changfeng" <Changfeng.Zhu@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Huang, Ray"
 <Ray.Huang@amd.com>, "Huang, Shimmer" <Xinmei.Huang@amd.com>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu: avoid using invalidate semaphore for
 picasso(v2)
Thread-Topic: [PATCH] drm/amdgpu: avoid using invalidate semaphore for
 picasso(v2)
Thread-Index: AQHVrwVJBbTNOhQRdkmgbQfUpmBrZKezMp6AgAAAjhA=
Date: Tue, 10 Dec 2019 11:03:44 +0000
Message-ID: <MN2PR12MB28960B7A862EB9DA041CF034FD5B0@MN2PR12MB2896.namprd12.prod.outlook.com>
References: <20191210025513.14625-1-changfeng.zhu@amd.com>
 <87718283-3287-819e-ee9f-a3d57112bc5d@amd.com>
In-Reply-To: <87718283-3287-819e-ee9f-a3d57112bc5d@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2019-12-10T11:03:41Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=d8685622-20b2-4d33-baad-00005c944b58;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2019-12-10T11:03:41Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 6963aa49-df16-499a-ab81-00006b6e0546
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Changfeng.Zhu@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f07b5d5f-7849-4df9-e509-08d77d609fc3
x-ms-traffictypediagnostic: MN2PR12MB3165:|MN2PR12MB3165:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB316507B5E6EA686104A2E3AAFD5B0@MN2PR12MB3165.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 02475B2A01
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(39860400002)(366004)(346002)(376002)(136003)(199004)(189003)(13464003)(53546011)(316002)(2906002)(186003)(52536014)(478600001)(6506007)(81156014)(8676002)(110136005)(33656002)(86362001)(6636002)(26005)(81166006)(5660300002)(71200400001)(66446008)(9686003)(55016002)(66946007)(8936002)(7696005)(76116006)(66476007)(66556008)(64756008);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3165;
 H:MN2PR12MB2896.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8BEP7LChnWAIxku1uPNmIyM/gDR07YOiWljGZwP0rpEHKQblE4NKbrO6B/OuP5o1hpnsipzJ44GbKY+RG/mdhfeEd58wB29+Yg8GR8AZaXUhwCafYNsuh8ZlqaX7cwr9N9c614eVyccLl19DoAiY9bApmGJshHjXCKnGpIoMVl2kEqyPaRH6i2yUD2X5SChXZQz5ikTAa5mXN3y60NopwceLYtZsY69ub4IHDQH9xjXfmq7OfIlcEzrRi1DL2usSlQpG4txICqWa+Aa8GHM5hiQsXAk+2zwQP/f23L/7sBefRZCDFj3vw9wXjiVcBtXzADabqq957kT0ylXRpP80tRPMC08hw5XG5SHlmsVznO6n/cv5sI/ultM058J8oClAWJ0Ggl2eOWLn1Mfl+PKGYU6/JHsI1m+Zp577wQXsHD3Rk+ccMYOZ+lVp4qXDAfZQVa7+JBLmH2HXcF+t+yA3OFZuMC3RnZlDWM9VwFJ4dQmUu5lL2m/7Iz4A6dxpKgFS
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f07b5d5f-7849-4df9-e509-08d77d609fc3
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2019 11:03:44.5053 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TeuNmGOyl1/nU8jpVEul/U3kuv06Quy3cx6rZIHDRrwDqdBx6F33HMquenQudpoMQSnZpDw15OIGN26R67Vm5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3165
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

OK, Chris.

What's about SRIOV?

Should we skip using semaphore registers for SRIOV now?

I add REG32_SOC15_OFFSET(MMHUB, 0, mmVM_INVALIDATE_ENG0_SEM, i, 0x0);
in mmhub_v1_0_program_invalidation.

However, the problem still happens.

BR,
Changfeng,

-----Original Message-----
From: Koenig, Christian <Christian.Koenig@amd.com> 
Sent: Tuesday, December 10, 2019 6:55 PM
To: Zhu, Changfeng <Changfeng.Zhu@amd.com>; amd-gfx@lists.freedesktop.org; Huang, Ray <Ray.Huang@amd.com>; Huang, Shimmer <Xinmei.Huang@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: Re: [PATCH] drm/amdgpu: avoid using invalidate semaphore for picasso(v2)

Am 10.12.19 um 03:55 schrieb Changfeng.Zhu:
> From: changzhu <Changfeng.Zhu@amd.com>
>
> It may cause timeout waiting for sem acquire in VM flush when using 
> invalidate semaphore for picasso. So it needs to avoid using 
> invalidate semaphore for piasso.

It would probably be better to add a small helper function to decide if the semaphore registers should be used or not.

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
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c 
> b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
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
>   			tmp = RREG32_NO_KIQ(hub->vm_inv_eng0_sem + eng); @@ -495,8 
> +498,11 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
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
>   		 * write with 0 means semaphore release @@ -527,8 +533,11 @@ 
> static uint64_t gmc_v9_0_emit_flush_gpu_tlb(struct amdgpu_ring *ring,
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
>   					  hub->vm_inv_eng0_sem + eng, 0x1, 0x1); @@ -544,8 +553,11 @@ 
> static uint64_t gmc_v9_0_emit_flush_gpu_tlb(struct amdgpu_ring *ring,
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
